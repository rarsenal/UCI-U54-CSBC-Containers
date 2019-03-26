task UCI_U54_Interactive_Seurat3Env {

    command {
        start-singleuser.sh
    }

    runtime {
        docker: 'ucigenomics/ghtf-r3.5-jpy-seurat3:latest'
    }
}

workflow UCI_U54_Interactive_Seurat3Env {
    call UCI_U54_Interactive_Seurat3Env
}

