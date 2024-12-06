#!/usr/bin/env nextflow

// Workflow used to analyze a collection of regions

include { analyze_regions } from './modules/analyze_regions'

workflow {
    if (!params.regions) {
        error "Parameter 'regions' is required but not provided."
    }

    if (!params.outdir) {
        error "Parameter 'outdir' is required but not provided."
    }

    log.info """
#################################
# QUANTITATIVE SPATIAL ANALYSIS #
#################################

Analyzing regions: ${params.regions}
    """

    regions = Channel
        .fromPath(params.regions, checkIfExists: true)
        .splitCsv(header: true, sep: ',')

    analyze_regions(regions)

}