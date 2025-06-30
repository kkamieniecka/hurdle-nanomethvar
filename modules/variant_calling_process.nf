process VARIANT_CALLING {
    input:
    path bam
    path ref

    output:
    path "variants.vcf"

    script:
    """
    longshot --bam $bam --ref $ref --out variants.vcf
    """
}
