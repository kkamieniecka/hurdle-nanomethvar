include { REPORT } from '../modules/report_process.nf'

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
