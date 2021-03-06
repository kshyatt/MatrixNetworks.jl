function bipartite_matching_test()
    W = sprand(10,8,0.5)
    bipartite_matching(W)
    bipartite_matching([10;12;13],[1;2;3],[3;2;4])
    
    A = [5 1 1 1 1;
     1 5 1 1 1;
     1 1 5 1 1;
     1 1 1 5 1;
     1 1 1 1 5;
     1 1 1 1 1]
    A = sparse(A)
    M1 = bipartite_matching(A)
    (m1,m2) = edge_list(M1)
     
    if M1.weight != 25 || !isequal(m1,m2)
        error("bipartite matching failed")
    end
    
    A = ones(Int64,6,5) - eye(Int64,6,5)
    A = sparse(A')
    (ei,ej,ev) = csr_to_sparse(A.colptr,A.rowval,A.nzval)
    ai = [1;2;3;4;5;ei]
    aj = [1;2;3;4;5;ej]
    av = [5;5;5;5;5;ev]
    
    M2 = bipartite_matching(av,ai,aj)
    mi = MatrixNetworks.edge_indicator(M2,ai,aj)
    mitrue = zeros(Int64,length(av))
    mitrue[1:5] = 1
    
    if M2.weight != 25 || !isequal(m1,m2) || sum(mi) !=5 || !isequal(mi,mitrue)
        error("bipartite matching failed")
    end
    
    M2 = bipartite_matching(av,ai,aj,maximum(ai),maximum(aj))
    mi = MatrixNetworks.edge_indicator(M2,ai,aj)
    mitrue = zeros(Int64,length(av))
    mitrue[1:5] = 1
    
    if M2.weight != 25 || !isequal(m1,m2) || sum(mi) !=5 || !isequal(mi,mitrue)
        error("bipartite matching failed")
    end
    
    return true
end
