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

workflow hurdle_nanomethvar_variant_calling {
    take:
    bam
    ref

    main:
    VARIANT_CALLING(bam, ref)

    emit:
    VARIANT_CALLING.out
}
