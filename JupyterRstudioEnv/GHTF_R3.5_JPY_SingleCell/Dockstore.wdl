task UCI_U54_Interactive_SingleCellEnv {

    command {
        start-singleuser.sh
    }

    runtime {
        docker: 'ucigenomics/ghtf-r3.5-jpy-singlecell:latest'
    }
}

workflow UCI_U54_Interactive_SingleCellEnv {
    call UCI_U54_Interactive_SingleCellEnv
}

