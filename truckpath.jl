using Graphs
using SparseArrays # 희소 행렬 생성을 위해 필요

# ==============================================================================
# 경로 복원 헬퍼 함수
# ==============================================================================
function reconstruct_path(parents::Vector{Int}, source::Int, target::Int)
    path = Int[]
    curr = target
    while curr != 0 && curr != source
        pushfirst!(path, curr)
        curr = parents[curr]
    end
    if curr == source
        pushfirst!(path, source)
        return path
    else
        return Int[]
    end
end

# ==============================================================================
# 1. 최적화된 트럭 높이 & 중량 제약 경로 탐색 함수
# ==============================================================================
function find_truck_route_fast(num_nodes::Int, 
                               roads::Vector{Tuple{Int, Int, Float64, Float64, Float64}}, 
                               truck_height::Float64, truck_weight::Float64, 
                               source::Int, target::Int)
    g = SimpleDiGraph(num_nodes)
    
    # 희소 행렬 생성을 위한 Coordinate(COO) 백터 pre-allocation
    I_nodes = Int[]
    J_nodes = Int[]
    V_dists = Float64[]
    
    sizehint!(I_nodes, length(roads))
    sizehint!(J_nodes, length(roads))
    sizehint!(V_dists, length(roads))

    # 통과 가능한 도로만 그래프에 추가 (Pruning)
    for (u, v, dist, h_limit, w_limit) in roads
        if h_limit >= truck_height && w_limit >= truck_weight
            add_edge!(g, u, v)
            push!(I_nodes, u)
            push!(J_nodes, v)
            push!(V_dists, dist)
        end
    end

    # O(E) 공간 복잡도를 가지는 희소 가중치 행렬 생성
    weights = sparse(I_nodes, J_nodes, V_dists, num_nodes, num_nodes)

    ds = dijkstra_shortest_paths(g, source, weights)
    path = reconstruct_path(ds.parents, source, target)

    return (distance = ds.dists[target], path = path)
end

# ==============================================================================
# 2. 최적화된 회전 제약(선대그래프) 경로 탐색 함수
# ==============================================================================
function find_route_with_turn_restrictions_fast(num_nodes::Int,
                                                edges_list::Vector{Tuple{Int, Int}}, 
                                                edge_distances::Vector{Float64}, 
                                                turn_restrictions::Dict{Tuple{Tuple{Int, Int}, Tuple{Int, Int}}, Float64}, 
                                                start_edge_idx::Int, target_edge_idx::Int)
    num_edges = length(edges_list)

    # O(E^2) 2중 루프 방지를 위한 노드별 진입/진출 에지 인덱싱 O(E)
    in_edges = [Int[] for _ in 1:num_nodes]
    out_edges = [Int[] for _ in 1:num_nodes]

    for (idx, (u, v)) in enumerate(edges_list)
        push!(out_edges[u], idx)
        push!(in_edges[v], idx)
    end

    state_graph = SimpleDiGraph(num_edges)
    I_states = Int[]
    J_states = Int[]
    V_costs = Float64[]

    # 교차로(v) 기준 연결: O(E * 차수) 연산으로 국한
    for v in 1:num_nodes
        for e_in_idx in in_edges[v]
            u1, v1 = edges_list[e_in_idx]
            for e_out_idx in out_edges[v]
                u2, v2 = edges_list[e_out_idx]
                
                turn_cost = get(turn_restrictions, ((u1, v1), (u2, v2)), 0.0)
                if turn_cost != Inf
                    add_edge!(state_graph, e_in_idx, e_out_idx)
                    push!(I_states, e_in_idx)
                    push!(J_states, e_out_idx)
                    push!(V_costs, edge_distances[e_out_idx] + turn_cost)
                end
            end
        end
    end

    # 상태 그래프 가중치 희소 행렬화
    state_weights = sparse(I_states, J_states, V_costs, num_edges, num_edges)

    ds = dijkstra_shortest_paths(state_graph, start_edge_idx, state_weights)
    raw_dist = ds.dists[target_edge_idx]

    if raw_dist == Inf
        return (distance = Inf, edge_path = Int[], node_path = Int[])
    end

    total_dist = raw_dist + edge_distances[start_edge_idx]
    edge_path = reconstruct_path(ds.parents, start_edge_idx, target_edge_idx)

    # 방문 노드 순서 추적
    node_path = Int[edges_list[edge_path[1]][1]]
    for idx in edge_path
        push!(node_path, edges_list[idx][2])
    end

    return (distance = total_dist, edge_path = edge_path, node_path = node_path)
end

# ==============================================================================
# 실행 테스트
# ==============================================================================
function main()
    println("--- [1. 최적화된 트럭 규격 제약 탐색] ---")
    roads = [
        (1, 2, 10.0, 4.5, 40.0),
        (1, 3, 12.0, 3.5, 30.0),
        (2, 4, 15.0, 4.2, 25.0),
        (3, 4,  5.0, 4.5, 40.0),
        (4, 5,  8.0, 4.0, 40.0)
    ]
    res1 = find_truck_route_fast(5, roads, 3.8, 28.0, 1, 5)
    println("최단 거리: $(res1.distance) km | 경로: $(join(res1.path, " -> "))")

    println("\n--- [2. 최적화된 회전 제약 탐색] ---")
    edges = [(1, 2), (2, 3), (2, 4), (3, 5), (4, 5)]
    edge_dists = [10.0, 5.0, 6.0, 8.0, 7.0]
    turn_rules = Dict(((1, 2), (2, 4)) => Inf) # 1->2->4 좌회전 금지

    res2 = find_route_with_turn_restrictions_fast(5, edges, edge_dists, turn_rules, 1, 4)
    println("최단 비용: $(res2.distance) | 방문 노드: $(join(res2.node_path, " -> "))")
end

main()
