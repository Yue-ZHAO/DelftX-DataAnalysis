integer_breaks <- function(n = 5, ...) {
  library("scales")
  breaker <- pretty_breaks(n, ...)
  function(x) {
     breaks <- breaker(x)
     breaks[breaks == floor(breaks)]
  }
}

# ggplot(EX101x_3T2015_scoredistribution, aes(x=score, fill=rel_week)) + geom_histogram(binwidth = 0.05) + facet_grid(group~rel_week, scales="free_y") + ylab("# Passer") + xlab("Score") + theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1)) + guides(fill=FALSE) + scale_x_continuous(breaks=c(0.0, 0.25, 0.50, 0.75, 1.00)) + scale_y_continuous(breaks = integer_breaks())