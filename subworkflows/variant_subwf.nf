include { VARIANT_CALLING } from '../modules/variant_calling_process.nf'

workflow hurdle_nanomethvar_variant_calling {
    take:
    bam
    ref

    main:
    VARIANT_CALLING(bam, ref)

    emit:
    VARIANT_CALLING.out
}
