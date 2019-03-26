task UCI_U54_Interactive_BaseEnv {

    command {
        start-singleuser.sh
    }

    runtime {
        docker: 'ucigenomics/ghtf-r3.5-jpy-base:latest'
    }
}

workflow UCI_U54_Interactive_BaseEnv {
    call UCI_U54_Interactive_BaseEnv
}

