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