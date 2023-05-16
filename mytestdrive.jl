using Gtk, Distributed

btn = GtkButton("Start")
sp = GtkSpinner()
ent = GtkEntry()

grid = GtkGrid()
grid[1,1] = btn
grid[2,1] = sp
grid[1:2,2] = ent

id = addprocs(1)[1]

signal_connect(btn, "clicked") do widget
    start(sp)
    @async begin

        # Offload work to a separate process and block until it is done.
        counter = @fetchfrom id begin
            stop_time = time() + 3
            counter = 0
            while time() < stop_time
                counter += 1
            end
            counter
        end

        # We are still in the main thread so it is okay to directly access widgets
        stop(sp)
        set_gtk_property!(ent, :text, "I counted to $counter in a separate process!")
    end
end

win = GtkWindow(grid, "Distributed", 200, 200)
showall(win)