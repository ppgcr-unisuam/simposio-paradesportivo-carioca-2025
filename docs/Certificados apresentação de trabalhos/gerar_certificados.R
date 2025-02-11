# read XLSX file with data
data <- readxl::read_xlsx("Submissao de Tema Livre - VIII Simposio  Paradesportivo Carioca (respostas).xlsx")
# change case
data$`Nome completo do (s) autor (es)` <- toupper(tolower(data$`Nome completo do (s) autor (es)`))
data$`Título do trabalho` <- toupper(tolower(data$`Título do trabalho`))

# replace 1 by ¹
data$`Nome completo do (s) autor (es)` <- gsub("1", "¹", data$`Nome completo do (s) autor (es)`)
# replace 2 by ²
data$`Nome completo do (s) autor (es)` <- gsub("2", "²", data$`Nome completo do (s) autor (es)`)
# replace 3 by ³
data$`Nome completo do (s) autor (es)` <- gsub("3", "³", data$`Nome completo do (s) autor (es)`)
# replace 4 by ⁴
data$`Nome completo do (s) autor (es)` <- gsub("4", "⁴", data$`Nome completo do (s) autor (es)`)
# replace 5 by ⁵
data$`Nome completo do (s) autor (es)` <- gsub("5", "⁵", data$`Nome completo do (s) autor (es)`)
# replace 6 by ⁶
data$`Nome completo do (s) autor (es)` <- gsub("6", "⁶", data$`Nome completo do (s) autor (es)`)
# replace 7 by ⁷
data$`Nome completo do (s) autor (es)` <- gsub("7", "⁷", data$`Nome completo do (s) autor (es)`)
# replace 8 by ⁸
data$`Nome completo do (s) autor (es)` <- gsub("8", "⁸", data$`Nome completo do (s) autor (es)`)
# replace 9 by ⁹
data$`Nome completo do (s) autor (es)` <- gsub("9", "⁹", data$`Nome completo do (s) autor (es)`)
# replace 0 by ⁰
data$`Nome completo do (s) autor (es)` <- gsub("0", "⁰", data$`Nome completo do (s) autor (es)`)
# replace " , " by ", "
data$`Nome completo do (s) autor (es)` <- gsub(" , ", ", ", data$`Nome completo do (s) autor (es)`)
# replace " ; " by "; "
data$`Nome completo do (s) autor (es)` <- gsub(" ; ", "; ", data$`Nome completo do (s) autor (es)`)

# remove trailig dots
data$`Nome completo do (s) autor (es)` <- gsub("\\.$", "", data$`Nome completo do (s) autor (es)`)
data$`Título do trabalho` <- gsub("\\.$", "", data$`Título do trabalho`)

# create folder
dir.create("Certificados", showWarnings = FALSE)

# loop over participants
for(i in 1:dim(data)[1]){
  autores <- data$`Nome completo do (s) autor (es)`[i]
  título <- data$`Título do trabalho`[i]
  txt <- paste0("Certificamos que ", autores, " apresentaram o trabalho ", título, " no VIII Simpósio Paradesportivo Carioca, realizado em 18 de setembro de 2024, na UNISUAM, Unidade Bonsucesso.")
  # Adjust text to fit margins using strwrap
  txt_wrapped <- paste(strwrap(txt, width = 70), collapse = "\n")
  # create certificate
  pdf("Part2.pdf", , width = 11.69, height = 8.27)
  plot.new()
  # Add text
  text(x = 0.48, y = 0.57, cex = 1.25, adj = c(0.5,0.5), labels = txt_wrapped, col = "darkgrey")
  # save file
  dev.off()
  # Files to overlay
  f1 <- "TEMPLATE.pdf"
  f2 <- "Part2.pdf"
  qpdf::pdf_overlay_stamp(input = f1, stamp = f2, output = paste0("Certificados/", "[", sprintf("%003d", i), "] ", título, ".pdf"))
  # delete Part2.pdf
  file.remove("Part2.pdf")
}
# enjoy