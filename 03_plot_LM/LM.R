ggplot(data, aes(x=POS, y=FEMALE_POS, color=CHR))+
  geom_point(size = 1)+
  facet_wrap(~CHR)+
  labs(y="Centimorgans", x="reference genome position")+
  theme_bw()
