.get_td <- function(intext, tr_blocks) {
    tr_blocks %>% rvest::html_node("td") -> td_block
    td_block %>% rvest::html_text() %>% stringr::str_trim() %>% `==`(intext) %>% which() -> idx
    tr_blocks[idx] %>% rvest::html_nodes('td') -> target_td
    target_td[2] %>% rvest::html_text()
}

.extract_article <- function(article_unit) {
    article_unit %>% rvest::html_nodes("tr") -> tr_blocks
    .get_td("PD", tr_blocks) -> pubdate
    .get_td("LP", tr_blocks) -> lede
    .get_td("TD", tr_blocks) -> body
    .get_td("HD", tr_blocks) -> headline
    .get_td("SN", tr_blocks) -> source
    return(tibble::tibble(pubdate, headline, lede, body, source))
}

.extract_articles <- function(path, id = "MNG") {
    xml2::read_html(path) -> parsed_article
    parsed_article %>% rvest::html_nodes(paste0("div.enArticle")) -> article_units
    purrr::map_dfr(article_units, .extract_article)
}

#' @export
avitcaf <- function(...) {
    input_paths <- list(...)
    purrr::map_dfr(input_paths, .extract_articles)
}
