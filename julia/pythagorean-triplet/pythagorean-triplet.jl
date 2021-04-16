

function is_triplet(a, b, c)
    a^2 + b^2 == c^2
    
end

function find_triplets(n)
    first_third = n / 3
    middle_third = n - first_third
    for x in 1:first_third, y in first_third:middle_third, z in middle_third:n
        if is_triplet(x,y,z) || is_triplet(y,z,x) || is_triplet(z,x,y)
            if (x + y + z) == n
                println("$x, $y, $z")
            end
        end
    end
end