using Flux
using Flux: onehot, chunk, batchseq, crossentropy, throttle

# Define the RNN model
function build_model(vocab_size, hidden_size)
    return Chain(
        LSTM(vocab_size, hidden_size),
        LSTM(hidden_size, hidden_size),
        Dense(hidden_size, vocab_size),
        softmax,
    )
end

# Define the loss functions.
function loss(model, inputs, targets)
    preds = model.(inputs)
    return crossentropy.(preds, targets)
end

# Generate sample data
data = ["hello world", "world hello", "hello again", "again hello"]
alphabet = ['a':'z', ' ']
char_to_int = Dict(c => i for (i, c) in enumerate(alphabet))
int_to_char = Dict(i => c for (i, c) in enumerate(alphabet))
n_chars = length(alphabet)
n_seqs = length(data)

# Convert data to one-hot encoding
inputs = [onehot([char_to_int[c] for c in data[i]]) for i in 1:n_seqs]
targets = [onehot([char_to_int[c] for c in data[i][2:end] * " " * " "]) for i in 1:n_seqs]

# Define the RNN model and loss function
model = build_model(n_chars, 128)
loss(x, y) = Flux.Losses.logitbinarycrossentropy(model(x), y)

# Train the RNN
opt = Flux.Optimiser(Adam(0.01))
for i in 1:1000
    Flux.train!(loss, [(inputs[i], targets[i]) for i in 1:n_seqs], opt)
end

# Generate some text using the trained RNN
function generate_text(model, seed, length)
    text = seed
    hidden = zeros(model.layers[1].hidden_size)
    for i in 1:length
        input = onehot([char_to_int[c] for c in text[end]])
        output = model(input, hidden)
        hidden = output[2][1]
        dist = Flux.softmax(output[1])
        char = int_to_char[argmax(Array(dist))]
        text *= char
    end
    return text
end

println(generate_text(model, "hello", 10)) # generates "hello aga again" (may vary due to random initialization and training) 
