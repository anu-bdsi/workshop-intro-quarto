learning_objectives <- function(highlight = NULL) {
  lines <- readLines("_learning-objectives.qmd") |> 
    stringr::str_replace("^- ", "")
  
  lines <- lines[lines!=""]
  
  if(is.null(highlight)) highlight <- 1:length(lines) 
  
  lines <- ifelse(1:length(lines) %in% highlight, 
                  paste0("<li> <span class='fa-li'><i class='fas fa-arrow-right'></i></span>", lines, "</li>") , 
                  paste0("<li style='opacity:0.25;'><span class='fa-li'>-</span>", lines, "</li>"))
  
  cat(c('<ul class="fa-ul">',
         lines,
         '</ul>'), sep = "\n")
}

content <- readr::read_csv("data/content.csv")

exercise_countdown <- function(id) {
  content |> 
    dplyr::filter(type=="exercise", content_id==id) |> 
    dplyr::pull(time) |> 
    countdown::countdown(font_size = "3em", color_background = "white", color_text = "black")
}

fa_file <- function(ext) {
  glue::glue('<span class="fa-layers fa-fw"><i class="fas fa-file"></i><span class="fa-layers-text fa-inverse" data-fa-transform="shrink-11 down-3" style="font-weight:900;color:grey;">{ext}</span></span>')
}


example_doc <- function(id) {
  ex <- sprintf("example-%.2d.qmd", id)
  paste0("🔍 Open and inspect the file <a href='/exercises/", ex, "' download>`", ex, "`</a>")
}