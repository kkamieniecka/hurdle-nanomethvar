nextflow.enable.dsl = 2

include { hurdle_nanomethvar_qc } from './subworkflows/qc_subwf.nf'
include { hurdle_nanomethvar_variant_calling } from './subworkflows/variant_subwf.nf'
include { hurdle_nanomethvar_methylation } from './subworkflows/methylation_subwf.nf'
include { hurdle_nanomethvar_report } from './subworkflows/report_subwf.nf'

workflow {

    fast5_ch = Channel.fromPath("fast5_files/")
    fastq_ch = Channel.fromPath("reads.fastq")
    bam_ch   = Channel.fromPath("reads.sorted.bam")
    ref_ch   = Channel.fromPath("humangenome.fa")

    qc_out = hurdle_nanomethvar_qc(fastq_ch, bam_ch)
    variant_out = hurdle_nanomethvar_variant_calling(bam_ch, ref_ch)

    // methylation emits a tuple of outputs
    methyl_out_tuple = hurdle_nanomethvar_methylation(fast5_ch, fastq_ch, bam_ch, ref_ch)

    // Pass tuple directly as one input
    report_out = hurdle_nanomethvar_report(qc_out, variant_out, methyl_out_tuple)
}
