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
    .get_td("AN", tr_blocks) -> uid
    return(tibble::tibble(uid, pubdate, headline, lede, body, source))
}

.guess_id <- function(parsed_article) {
    parsed_article %>% rvest::html_nodes("div.article") %>% rvest::html_attr(name = "class") %>% stringr::str_split(" ") %>% unlist %>% unique -> all_classes
    return(all_classes[all_classes != "article"][1])
}

.extract_articles <- function(path, id = "guess") {
    xml2::read_html(path) -> parsed_article
    if (id == "guess") {
        id <- paste0("div.", .guess_id(parsed_article))
    }
    parsed_article %>% rvest::html_nodes(id) -> article_units
    purrr::map_dfr(article_units, .extract_article)
}

#' @export
avitcaf <- function(..., id = "guess") {
    input_paths <- list(...)
    if (length(input_paths[[1]]) != 1) {
        ## it is a vector
        input_paths <- unlist(input_paths)
    }
    purrr::map_dfr(input_paths, .extract_articles, id = id)
}
