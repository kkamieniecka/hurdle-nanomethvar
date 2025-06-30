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
