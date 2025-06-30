# 🚀 Nanopore Nextflow Modular Pipeline

[![Nextflow](https://img.shields.io/badge/built%20with-nextflow-brightgreen)](https://www.nextflow.io/) 
[![Docker](https://img.shields.io/badge/container-docker-blue)](https://www.docker.com/) 
[![GitPod](https://debug-kkamienieck-hurdlenanom-6ctrg50hget.ws-eu120.gitpod.io/)
[![MIT License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)


---

## 🧬 Overview

This **Nextflow DSL2** pipeline processes Oxford Nanopore sequencing data using a modular and containerized approach.  

✔️ Basic QC of raw reads and alignments  
✔️ Variant calling using Longshot  
✔️ Methylation calling and event alignment using f5c  
✔️ Summary reporting with MultiQC

---
In older nf-core/nanoseq DSL1 pipelines, it was technically possible to incorporate custom scripts or run methylation tools like f5c in a simpler, monolithic workflow block.

However, this approach lacked proper modularity, reproducibility, and best practices — which are now strongly encouraged in Nextflow DSL2.

In DSL2, processes and modules are explicitly defined and isolated, which improves maintainability and cloud readiness.
As a result, while it was easier to "hack in" methylation steps in DSL1 (even alongside nf-core/nanoseq workflows), this is not recommended or supported in modern, production-level DSL2 pipelines.
## 📥 Inputs

- `fast5_files/`: **Per-read raw signal data** (from MinION/GridION runs)
- `reads.fastq`: **Basecalled reads** (already done, so no Guppy required)
- `reads.sorted.bam`: **Sorted BAM**, aligned to reference
- `humangenome.fa`: **Reference genome**, plus `.fai` index

---

- **f5c** is a fast, optimized fork of Nanopolish. It performs **signal-level methylation calling**, leveraging FAST5 + FASTQ + BAM + reference to accurately identify methylated sites and perform event-level analysis.

---

## 🗺️ Workflow modules

### 🟢 QC

- **NanoPlot**: assesses read length, quality, and throughput.
- **Samtools flagstat**: basic alignment summary stats.

### 🟠 Variant Calling

- **Longshot**: accurate SNP and indel calling optimized for ONT data.
  ## 🧬 Comparison table for variant calling on Oxford Nanopore data

| Tool            | Variant types          | Strengths                                                    | Weaknesses                                   | Recommended use case                                  |
|-----------------|------------------------|--------------------------------------------------------------|---------------------------------------------|-------------------------------------------------------|
| **Longshot**    | SNPs & small indels (≤50 bp) | ✔ High precision on SNPs<br>✔ Haplotype-aware<br>✔ Simple CPU run | ✘ No structural variants<br>✘ Per-sample only | High-confidence SNP and small indel calling from ONT |
| **Clair3**      | SNPs & indels          | ✔ High recall & precision<br>✔ Deep-learning-based<br>✔ Works on noisy data | ✘ GPU recommended<br>✘ More complex setup | Comprehensive small variant calling, including difficult regions |
| **Medaka variant** | SNPs & small indels | ✔ Oxford Nanopore-specific<br>✔ Integrated with basecalling workflows | ✘ Slightly lower precision<br>✘ Slower     | Simpler ONT-only variant calling; paired with ONT workflows |
| **Sniffles**    | Structural variants (SVs) | ✔ Detects large insertions, deletions, inversions, translocations | ✘ Not designed for SNPs/indels          | Discovering large SVs in ONT or PacBio data         |
| **SVIM**        | Structural variants    | ✔ SV discovery including complex events                     | ✘ No small variant support                | Complement to small variant callers                 |

---

### 💡 Key recommendations

- ✅ **Use Longshot** if your main interest is **SNPs and small indels**, and you want an easy-to-run, high-precision tool.
- ✅ **Add Sniffles or SVIM** if you also want to detect large SVs.
- ✅ **Consider Clair3** if you have GPU resources and want maximum sensitivity in challenging genomic regions.

---

### 🟢 Suggested "best practice" combination

> **Longshot + Sniffles (or SVIM)** → covers both small variants and large SVs in ONT data.


### 🔵 Methylation Calling
## 🧬 Comparison: f5c vs other methylation tools for Nanopore data

| Tool            | Raw signal-level? | Speed & performance     | Accuracy       | Actively maintained | Recommended for large genomes? | Notes                                  |
|-----------------|--------------------|------------------------|---------------|---------------------|-------------------------------|----------------------------------------|
| **f5c**         | ✅ Yes             | ⚡ Very fast (optimized) | ✅ High       | ✅ Yes             | ✅ Yes                       | Supports FAST5 and BLOW5; fork of Nanopolish; GPU/CPU acceleration. |
| Nanopolish      | ✅ Yes             | 🐢 Slow                | ✅ High       | ⚠️ Limited        | ⚠️ Limited                  | Original signal-level tool; legacy code; slow on large datasets. |
| Tombo           | ✅ Yes             | 🐢 Slow                | ⚖️ Medium    | ⚠️ Limited        | ⚠️ Limited                  | Good for exploratory modification detection; less optimized. |
| Guppy (basecaller mods) | ❌ No (approx. only) | ⚡ Fast             | ⚖️ Lower    | ✅ Yes             | ✅ Yes                       | Only provides approximate modification tags during basecalling; no event-level detail. |

---

### 💡 Why f5c?

- ✅ **Uses raw electrical signal (FAST5/SLOW5/BLOW5)** → essential for true methylation detection.
- ✅ **Much faster** than Nanopolish and Tombo, especially on large genomes.
- ✅ **Accurate**: based on established hidden Markov models trained for ONT signals.
- ✅ **Supports BLOW5**, providing further speed improvements.
- ✅ **Actively maintained**, future-proof.

---

### ⭐ **Summary**

> **If you have FAST5 or BLOW5 files and want accurate, high-performance methylation calls, f5c is the best choice today for Oxford Nanopore data.**

- `f5c index`: index FAST5 directory against FASTQ reads.
- `f5c call-methylation`: detect per-read methylation events.
- `f5c meth-freq`: generate methylation frequency summaries.
- `f5c eventalign`: map raw signal events to reference.

### 🟣 Report

- **MultiQC**: integrates outputs from all modules into a single HTML report.

---

## 💻 Usage

### Running locally

```bash
nextflow run main.nf -with-docker
```

**Docker**
```bash
docker build -t nanopore-pipeline docker/
```
**Cloud readiness**
- Ready for AWS Batch and Nextflow Tower.
- Supports S3 as a work directory for intermediate data:
  
```bash
workDir = 's3://your-bucket/work/'
```
