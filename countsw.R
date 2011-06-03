switches <- read.csv("~/Dropbox/R/data/chswall.csv")

where <- switches$Звідки.знято
where <- toupper(where) # всі в один регістр - верхній
csw <- unique(where) # рахуємо кількість однакових світчів

Switch <- rep ("NA", each = length(csw))
Counts <- rep (0, each = length(csw))

CountReplace <- data.frame(Switch, Counts)

# для кожної адреси  світча отримуємо скільки разів його міняли

for (i in 1:length(csw)){ 
  s <- where[where == csw[i]] 
  CountReplace$Switch  <- factor (CountReplace$Switch, levels = c (levels(CountReplace$Switch),  s[1]))
  CountReplace$Switch[i] = s[1]
  CountReplace$Counts[i] <-  length(s)
}

# додаткова інформація по світчах, як замінювали більше 3-ох раз

MaxCountReplace <- CountReplace[CountReplace$Count >2, ]
MaxChangedSWall <- switches[toupper(switches$Звідки.знято) == MaxCountReplace$Switch[2], c("Звідки.знято", "Дата",  "Чому.знято", "Тип.світча", "S.N")]

for (i in 3:length(MaxCountReplace$Switch)){
  MaxChangedSW <- switches[toupper(switches$Звідки.знято) == MaxCountReplace$Switch[i],c("Звідки.знято", "Дата",  "Чому.знято", "Тип.світча", "S.N")]
  MaxChangedSWall <- rbind(MaxChangedSWall, MaxChangedSW)
}

write.csv(MaxChangedSWall, "~/Dropbox/R/data/replacedsw.csv")



