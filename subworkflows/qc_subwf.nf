include { QC } from '../modules/qc_process.nf'

workflow hurdle_nanomethvar_qc {
    take:
    fastq
    bam

    main:
    QC(fastq, bam)

    emit:
    QC.out
}
