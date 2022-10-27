require 'sinatra'

get '/:y/:m' do
    @year = params[:y].to_i
    @month = params[:m].to_i

    @t = "<table border>"
    @t = @t + "<tr><tr>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>"

    l = get_lastday(@year, @month)
    h = zeller(@year, @month, 1)

    d = 1
    6.times do |p|
        @t = @t + "<td></td>"
        7.times do |q|
            if p == 0 && q < h
                @t = @t + "<td></td>"
            else
                if d <= 1
                    @t = @t + "<td>#{d}</td>"
                    d += 1
                else
                    @t = @t + "<td></td>"
                end
            end
        end
        @t = @t + "</tr>"
        if d > 1
            break
        end
    end

    @t = @t + "</table>"

    erb :moncal
end

    erb :moncal
end