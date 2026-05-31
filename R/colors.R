#' Complete list of palettes
#'
#' @export
hkitty_palettes <- list(
  hellokitty1 = c("#F81B44", "#0E52A6", "#FEDE08", "#000000"),
  hellokitty2 = c("#FBFF35", "#FFE0E9", "#DD88A5", "#FF20AF", "#FD003E")
)

#' A Hello kitty palette generator
#'
#' These are a handful of color palettes from Wes Anderson movies.
#'
#' @param n Number of colors desired. Unfortunately most palettes now only
#'   have 4 or 5 colors. But hopefully we'll add more palettes soon. All color
#'   schemes are derived from the most excellent Tumblr blog:
#'   \href{http://wesandersonpalettes.tumblr.com/}{Wes Anderson Palettes}.
#'   If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   \code{hellokitty1}, \code{hellokitty2}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' hkitty_palette("hellokitty1")
#' hkitty_palette("hellokitty2")
#' hkitty_palette("hellokitty1", 3)
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- hkitty_palette(21, name = "hellokitty2", type = "continuous")
#' image(volcano, col = pal)
hkitty_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)
  
  pal <- hkitty_palettes[[name]]
  if (type == "continuous" && name == "Zissou1") {
    pal <- wes_palettes[["Zissou1Continuous"]]
  }
  
  if (is.null(pal))
    stop("Palette not found.")
  
  if (missing(n)) {
    n <- length(pal)
  }
  
  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))
  
  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")
  
  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}

#' heatmap
#'
#' A heatmap example
"heatmap"