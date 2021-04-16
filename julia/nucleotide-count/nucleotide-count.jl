

"""
    count_nucleotides(strand)

The frequency of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)

    freq = Dict(n => 0 for n in "AGCT")

    for c in strand
        if !haskey(freq, c) 
            throw(DomainError(c))
        else
            freq[c] += 1
        end
    end
    
    freq
end


"""
The following two solutions come from the fantastic mentor CMCAINE, who
not only offered them up but explained them in wonderful detail.
"""
function count_nucleotides2(strand)

    counts = Dict((base => count(==(base), strand)) for base in "AGCT")

    if sum(values(counts)) != length(strand)
        throw(DomainError(strand))
    end
    counts
end


function count_nucleotides3(strand)

    utf8 = transcode(UInt8, strand)
    counts = zeros(Int, 256)

    @inbounds for byte in utf8
        counts[byte + 1] += 1
    end

    result = Dict(base => counts[Int(base) + 1] for base in "AGCT")

    if sum(values(result)) != length(strand)
        throw(DomainError(strand))
    end

    result
end


