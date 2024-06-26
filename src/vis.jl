circle = Makie.Polygon([Point2f(cos(a), sin(a)) for a in range(0, 2π, length=30)])

function Animattion(pos, dir, out_filepath::AbstractString = "test.mp4";
    framerate::Integer=30, isave=1, L = 1
)
 
    # fig, ax = wireframe(Sphere(Point3f(0), scale), linewidth=0.5, color=(:grey, 0.2))
    fig = Figure()
    ax = Axis(fig[1, 1])
    ax.aspect = DataAspect()
    limit = (-L, L, -L, L, -L, L)
    #ax = Axis3(fig[1, 1], limits=limit, aspect=:data)
    # pos = Observable(Point2f.(first(rt)))
    xs, ys = vec2comp.(pos)
    x = Observable(vec2comp(pos[1])[1])
    y = Observable(vec2comp(pos[1])[2])
    u = Observable(vec2comp(dir[1])[1])
    v = Observable(vec2comp(dir[1])[2])
    # pos = Observable(first(rt))
    # dir = Observable(first(nt))

    # strength = (sqrt.(u .^ 2 .+ v .^ 2))

    arrows!(ax, x, y, u, v, 
        linewidth=1, lengthscale= L / 40,
        align=:center)

    # scatter!(ax, pos)

    GLMakie.record(fig, out_filepath, eachindex(dir); framerate=framerate) do frame_i
        # pos[] = rt[frame_i]
        # dir[] = nt[frame_i]
        if frame_i % isave == 0
            x[], y[] = vec2comp(pos[frame_i])
            #  = ys[frame_i]
            # u_tmp, v_tmp = vec2comp(dir[frame_i])
            u[], v[] = vec2comp(dir[frame_i])
            # strength[] = Observable(sqrt.(u_tmp .^ 2 .+ v_tmp .^ 2))
        end
        # v[] = vs[frame_i]
    end
end

function Animattion(pos, dir, field, out_filepath::AbstractString="test.mp4";
    framerate::Integer=30, isave=1, L=1
)

    # fig, ax = wireframe(Sphere(Point3f(0), scale), linewidth=0.5, color=(:grey, 0.2))
    fig = Figure()
    ax = Axis(fig[1, 1])
    ax.aspect = DataAspect()
    limit = (-L, L, -L, L, -L, L)
    XS = 0:L
    YS = 0:L 
    #ax = Axis3(fig[1, 1], limits=limit, aspect=:data)
    # pos = Observable(Point2f.(first(rt)))
    # xs, ys = vec2comp.(pos)
    x = Observable(vec2comp(pos[1])[1])
    y = Observable(vec2comp(pos[1])[2])
    if dir[1] isa Vector{Float64}
        dir = [angle2dir.(ϕs) for ϕs in dir]
    end
    u = Observable(vec2comp(dir[1])[1])
    v = Observable(vec2comp(dir[1])[2])

    # pos = Observable(first(rt))
    # dir = Observable(first(nt))

    # strength = (sqrt.(u .^ 2 .+ v .^ 2))
    C = Observable(field[1])
    heatmap!(ax, XS, YS, C)
    arrows!(ax, x, y, u, v,
        linewidth=1, lengthscale=L / 40,
        align=:center)

    # scatter!(ax, pos)

    GLMakie.record(fig, out_filepath, eachindex(dir); framerate=framerate) do frame_i
        # pos[] = rt[frame_i]
        # dir[] = nt[frame_i]
        if frame_i % isave == 0
            x[], y[] = vec2comp(pos[frame_i])
            #  = ys[frame_i]
            # u_tmp, v_tmp = vec2comp(dir[frame_i])
            u[], v[] = vec2comp(dir[frame_i])
            # strength[] = Observable(sqrt.(u_tmp .^ 2 .+ v_tmp .^ 2))
            C[] = field[frame_i]
        end
        # v[] = vs[frame_i]
    end
end


function Animattion(all_pos, field::Matrix{Float64}, out_filepath::AbstractString="test.mp4";
    framerate::Integer=30, isave=1, L=1
)

    # fig, ax = wireframe(Sphere(Point3f(0), scale), linewidth=0.5, color=(:grey, 0.2))
    fig = Figure()
    ax = Axis(fig[1, 1])
    ax.aspect = DataAspect()
    limit = (-L, L, -L, L, -L, L)
    XS = 0:L
    YS = 0:L
    #ax = Axis3(fig[1, 1], limits=limit, aspect=:data)
    # pos = Observable(Point2f.(first(rt)))
    # xs, ys = vec2comp.(pos)
    # x = Observable(vec2comp(pos[1])[1])
    # y = Observable(vec2comp(pos[1])[2])
    # u = Observable(vec2comp(dir[1])[1])
    # v = Observable(vec2comp(dir[1])[2])
    pos = Observable(first(all_pos))
    # dir = Observable(first(nt))

    # strength = (sqrt.(u .^ 2 .+ v .^ 2))

    heatmap!(ax, XS, YS, field)
    # arrows!(ax, x, y, u, v,
    #     linewidth=1, lengthscale=L / 40,
    #     align=:center)

    scatter!(ax, pos, color=:"red", marker=circle,
        markersize=1,
        markerspace=:data,)

    GLMakie.record(fig, out_filepath, eachindex(all_pos); framerate=framerate) do frame_i
        # pos[] = rt[frame_i]
        # dir[] = nt[frame_i]
        # if frame_i % isave == 0
            # x[], y[] = vec2comp(pos[frame_i])
            #  = ys[frame_i]
            # u_tmp, v_tmp = vec2comp(dir[frame_i])
            # u[], v[] = vec2comp(dir[frame_i])
            # strength[] = Observable(sqrt.(u_tmp .^ 2 .+ v_tmp .^ 2))
            pos[] = all_pos[frame_i]
        # end
        # v[] = vs[frame_i]
    end
end



function snapshort(pos, dir, field)
    fig = Figure()
    ax = Axis(fig[1, 1])
    ax.aspect = DataAspect()
    limit = (-L, L, -L, L, -L, L)
    XS = 0:L
    YS = 0:L

    x = (vec2comp(pos)[1])
    y = (vec2comp(pos)[2])
    u = (vec2comp(dir)[1])
    v = (vec2comp(dir)[2])
    heatmap!(ax, XS, YS, field)
    arrows!(ax, x, y, u, v,
        linewidth=1, lengthscale=L / 40,
        align=:center)

    return fig
end
