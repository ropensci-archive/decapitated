#' Run headless
#'
#' @md
#' @param port remote debugging port (defaults to `9222`)
#' @param url visit this URL on start
#' @export
decapitate <- function(port=9222L, url=NULL) {

  tf <- tempfile(pattern = "chrome_", fileext = ".log")

  args <-  c("--headless", "--disable-gpu", sprintf("--remote-debugging-port=%s", as.integer(port)))
  if (!is.null(url)) args <- c(args, "--dump-dom", url)


  tmp <- system2(chrome_bin(), args, wait=FALSE, stdout=tf, stderr=tf)

  message(sprintf("Log file is at [%s]", tf))

}

#' Get the Chrome Remote ws URL
#'
#' @export
ws_url <- function(port=9222L) {
  chrome_url <- sprintf("http://localhost:%s/json", as.integer(port))
  tmp <- jsonlite::fromJSON(chrome_url, flatten=FALSE)
  tmp$webSocketDebuggerUrl
}

