# read XLSX file with data
data <- readxl::read_xlsx("Inscrição (respostas) (1).xlsx")
# change case
data$Nome <- toupper(tolower(data$Nome))
data$`Indique a sua matrícula, caso seja aluno da UNISUAM.` <- toupper(tolower(data$`Indique a sua matrícula, caso seja aluno da UNISUAM.`))

# create folder
certificates <- list.files("Certificados", full.names = TRUE, recursive = TRUE, include.dirs = TRUE, pattern = "pdf")

# loop over participants
for(i in 1:dim(data)[1]){
  print(i)
  # send email
  nome <- data$Nome[i]
  email <- data$`e-mail`[i]
  mailR::send.mail(from = "username@email",
                   to = c(paste0(nome, " <", email, ">"), "paradesportivocarioca@gmail.com"),
                   subject = "[Certificado] 8o Simpósio Paradesportivo Carioca",
                   body = paste0(
                    "Prezado(a)
                    <br><br>
                    <strong>", nome, "</strong>,<br><br>
                    Obrigado pela sua participação no <strong>8o Simpósio Paradesportivo Carioca</strong>.
                    <br><br>
                    Segue anexo o certificado.
                    <br><br>
                    Cordialmente,
                    <br><br>
                    Comissão Organizadora
                    <br>
                    Presidente - Prof. Dr. Patrícia dos Santos Vigário (UNISUAM)
                    <br><br>"),
            smtp = list(host.name = "smtp.gmail.com", port = 465,
                        user.name = "username@email",
                        # senhas de app do Google (CRIAR ANTES DE ENVIAR)
                        passwd = "****************", ssl = TRUE),
            authenticate = TRUE,
            send = TRUE,
            html = TRUE,
            attach.files = certificates[i]
  )
}
# enjoy