function matrix_network_datasets()
    datasets_location = joinpath(Pkg.dir("MatrixNetworks"),"data")
    content = readdir(datasets_location)
    smat_files = filter(x->contains(x,".smat"),content)
    return smat_files
    for i = 1:length(smat_files)
        smat_files[i] = smat_files[i][end-6]
    end
end