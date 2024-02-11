\name{BSgenome.Mmusculus.UCSC.mm10.masked}
\docType{package}

\alias{BSgenome.Mmusculus.UCSC.mm10.masked-package}
\alias{BSgenome.Mmusculus.UCSC.mm10.masked}

\title{Full masked genome sequences for Mus musculus (UCSC genome mm10, based on GRCm38.p6)}

\description{
  Full genome sequences for Mus musculus (Mouse) as provided by UCSC (genome mm10, based on GRCm38.p6) and stored in Biostrings objects. The sequences are the same as in BSgenome.Mmusculus.UCSC.mm10, except that each of them has the 2 following masks on top: (1) the mask of assembly gaps (AGAPS mask), and (2) the mask of intra-contig ambiguities (AMB mask).
}

\details{
  
}

\note{
  The masks in this BSgenome data package were made from the following
  source data files:
  \preformatted{
AGAPS masks: gap.txt.gz from http://hgdownload.cse.ucsc.edu/goldenPath/mm10/database/
RM masks: mm10.p6.fa.out.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/p6/ on Feb. 11, 2024
TRF masks: mm10.p6.trf.bed.gz, downloaded from https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/p6/ on Feb. 11, 2024
  }

  See \code{?\link[BSgenome.Mmusculus.UCSC.mm10]{BSgenome.Mmusculus.UCSC.mm10}} in the
  \pkg{BSgenome.Mmusculus.UCSC.mm10} package for information about how the sequences
  were obtained.

  See \code{?\link[BSgenome]{BSgenomeForge}} and the BSgenomeForge
  vignette (\code{vignette("BSgenomeForge")}) in the \pkg{BSgenome}
  software package for how to make a BSgenome data package.
}

\author{The Bioconductor Dev Team}

\seealso{
  \itemize{
    \item \link[BSgenome.Mmusculus.UCSC.mm10]{BSgenome.Mmusculus.UCSC.mm10} in the \pkg{BSgenome.Mmusculus.UCSC.mm10} package
          for information about how the sequences were obtained.
    \item \link[BSgenome]{BSgenome} objects and the
          \code{\link[BSgenome]{available.genomes}} function
          in the \pkg{BSgenome} software package.
    \item \link[Biostrings]{MaskedDNAString} objects in the \pkg{Biostrings}
          package.
    \item The BSgenomeForge vignette (\code{vignette("BSgenomeForge")})
          in the \pkg{BSgenome} software package for how to make a BSgenome
          data package.
  }
}

\examples{
BSgenome.Mmusculus.UCSC.mm10.masked
genome <- BSgenome.Mmusculus.UCSC.mm10.masked
head(seqlengths(genome))
genome$chr1  # a MaskedDNAString object!
## To get rid of the masks altogether:
unmasked(genome$chr1)  # same as BSgenome.Mmusculus.UCSC.mm10$chr1

if ("AGAPS" \%in\% masknames(genome)) {

  ## Check that the assembly gaps contain only Ns:
  checkOnlyNsInGaps <- function(seq)
  {
    ## Replace all masks by the inverted AGAPS mask
    masks(seq) <- gaps(masks(seq)["AGAPS"])
    unique_letters <- uniqueLetters(seq)
    if (any(unique_letters != "N"))
        stop("assembly gaps contain more than just Ns")
  }

  ## A message will be printed each time a sequence is removed
  ## from the cache:
  options(verbose=TRUE)

  for (seqname in seqnames(genome)) {
    cat("Checking sequence", seqname, "... ")
    seq <- genome[[seqname]]
    checkOnlyNsInGaps(seq)
    cat("OK\n")
  }
}

## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())
    vignette("GenomeSearching", package="BSgenome")
}

\keyword{package}
\keyword{data}
