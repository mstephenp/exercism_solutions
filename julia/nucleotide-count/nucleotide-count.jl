

"""
    count_nucleotides(strand)

The frequency of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    freq = Dict{Char, Int}(
        'A' => 0, 
        'G' => 0, 
        'C' => 0, 
        'T' => 0
    )

    for c in strand
        if !haskey(freq, c) 
            throw(DomainError(c))
        else
            freq[c] += 1
        end
    end
    
    freq
end
