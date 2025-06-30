process REPORT {
    input:
    path qc
    path variants
    path methylation

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc . -o .
    """
}

workflow hurdle_nanomethvar_report {
    take:
    qc
    variants
    methylation

    main:
    REPORT(qc, variants, methylation)

    emit:
    REPORT.out
}
