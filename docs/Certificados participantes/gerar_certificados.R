# read XLSX file with data
data <- readxl::read_xlsx("Inscrição (respostas) (1).xlsx")
# change case
data$Nome <- toupper(tolower(data$Nome))
data$`Indique a sua matrícula, caso seja aluno da UNISUAM.` <- toupper(tolower(data$`Indique a sua matrícula, caso seja aluno da UNISUAM.`))

# create folder
dir.create("Certificados", showWarnings = FALSE)

# loop over participants
for(i in 1:dim(data)[1]){
  # participant data
  if(is.na(data$`Indique a sua matrícula, caso seja aluno da UNISUAM.`[i])){
    txt <- data$Nome[i]
  } else {
    txt <- paste0(data$Nome[i], " (", data$`Indique a sua matrícula, caso seja aluno da UNISUAM.`[i], ")")
  }
  # create certificate
  pdf("Part2.pdf", , width = 11.69, height = 8.27)
  plot.new()
  # Add text
  text(x = 0.48, y = 0.64, cex = 1.75, adj = c(0.5,0.5), labels = txt, col = "darkgrey")
  # save file
  dev.off()
  # Files to overlay
  f1 <- "TEMPLATE.pdf"
  f2 <- "Part2.pdf"
  qpdf::pdf_overlay_stamp(input = f1, stamp = f2, output = paste0("Certificados/", "[", sprintf("%003d", i), "] ", "Evento_", txt, ".pdf"))
  # delete Part2.pdf
  file.remove("Part2.pdf")
}
# enjoy