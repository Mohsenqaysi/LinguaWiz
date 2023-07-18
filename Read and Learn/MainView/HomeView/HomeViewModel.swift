//
//  HomeViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 5/1/23.
//

import Foundation

struct Level: Codable, Identifiable, Equatable {
    static func == (lhs: Level, rhs: Level) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    let title: String
    let index: Int
    let subTitle: String
    let icon: String
    var readings: Reading
    var unlocked: Bool
    
    init(_ title: String, index: Int, subTitle: String, icon: String, readings: Reading, unlocked: Bool) {
        self.title = title
        self.index = index
        self.subTitle = subTitle
        self.icon = icon
        self.readings = readings
        self.unlocked = unlocked
    }
    
}

struct Reading: Codable, Identifiable {
    var id = UUID().uuidString
    let readings: [String]
    var fromIndex: Int
    
    init(_ readings: [String], fromIndex: Int = 0) {
        self.readings = readings
        self.fromIndex = fromIndex
    }
}


class HomeViewModel: ObservableObject {
    let appStorageUserlevel = UserDefaults.standard.string(forKey: "appStorageUserlevel")
    let curentLevel = UserDefaults.standard.integer(forKey: "curentLevel")
    let curentLevelReadingIndex = UserDefaults.standard.integer(forKey: "curentLevelReadingIndex")

    let userDefult = UserDefaults.standard
    let forKey = "levels"
    var selectedLevel: Level? {
        didSet {
            displaySelectedLevel = true
        }
    }
    @Published var levels: [Level] = [] {
        didSet {
            print("levels didSet: \(levels.count)")
        }
    }
    @Published var displaySelectedLevel: Bool = false
    
    init() {}
}

// MARK: VARS
extension HomeViewModel {
    var name: String {
        return "Hi their, welcome 😊"
    }
    
    private var level: [Level] {
        switch appStorageUserlevel {
        case "A1 - A2":
            return [
                Level("Level One", index: 0, subTitle: "A1 - A2", icon: levelOneIcon,
                      readings: Reading([
                        "Saudi Arabian cuisine is a blend of Arabian, Persian, and Indian influences. It is known for its rich flavors and spices, as well as its use of lamb, chicken, and rice. One of the most popular dishes in Saudi Arabia is called Kabsa. This is a flavorful rice dish that is usually served with chicken or lamb. The rice is cooked with a blend of spices, including saffron, cardamom, and cinnamon. The meat is usually cooked separately and then mixed with the rice. Saudi Arabian cuisine is an important part of the country's culture and is enjoyed by locals and visitors alike.",
                        "Saudi Arabia is a country rich in cultural traditions and holidays. One of the most important holidays is Eid al-Fitr, which marks the end of the month of Ramadan. During Eid al-Fitr, families gather together to celebrate with food, sweets, and gift-giving. Another important holiday is Eid al-Adha, which celebrates the end of the annual Hajj pilgrimage to Mecca. During this holiday, Muslims around the world sacrifice an animal and share the meat with their family, friends, and those in need. In addition to these religious holidays, Saudi Arabia also celebrates National Day on September 23rd. This holiday marks the day when King Abdulaziz united the country in 1932. Celebrations include parades, fireworks, and cultural events. Saudi Arabian holidays are a time for families and friends to come together and celebrate their shared heritage and traditions.",
                        "Saudi Arabia is home to many famous landmarks that attract tourists from all over the world. One of the most iconic landmarks is the Kaaba, located in the city of Mecca. The Kaaba is a black cube-shaped structure that is the holiest site in Islam. It is believed to have been built by the prophet Ibrahim and is the focal point of the annual Hajj pilgrimage. Another famous landmark is the Masmak Fortress, located in the city of Riyadh. The fortress was built in the 19th century and played a crucial role in the unification of Saudi Arabia. Visitors can explore the fortress and learn about its history. Saudi Arabia's famous landmarks are a testament to the country's rich history and cultural heritage.",
                        "Middle Eastern music is diverse and encompasses a wide range of styles and genres. One popular type of music is called oud music, which is played on a stringed instrument called an oud. The oud has a unique sound and is often used in both classical and contemporary Middle Eastern music. Another popular style of music is called belly dance music, which is often played during traditional belly dancing performances. This music is characterized by its rhythmic beats and use of instruments like the tambourine and finger cymbals. Middle Eastern music has a long history and is an important part of the region's cultural heritage.",
                        "Middle Eastern clothing varies from country to country, but there are some common styles and designs that can be found throughout the region. One traditional garment for men is the thobe, which is a long robe-like garment that is often worn for special occasions. Women's clothing also includes a long garment called an abaya, which covers the entire body except for the face, hands, and feet. Hijab is a head covering that is worn by many Muslim women as a sign of modesty and religious observance. Middle Eastern clothing is often made from light, flowing fabrics like cotton and silk, which help to keep the wearer cool in the hot climate. Traditional clothing is an important part of Middle Eastern culture and is often worn during religious festivals and other special occasions."
                      ]), unlocked: true),
                Level("Level Two", index: 1, subTitle: "A1 - A2", icon: levelTwoIcon, readings:
                        Reading([
                            "Sports are an important part of Middle Eastern culture and include a wide range of activities. One popular sport is football (soccer), which is played throughout the region and has a large following. Camel racing is also a traditional sport that is still practised in some parts of the region. In addition to team sports, there are also individual sports like boxing and wrestling that are popular. Many Middle Eastern countries also have their own traditional sports, such as kabaddi in Iran and jereed in Saudi Arabia. Sports are an important way for people to come together and celebrate their shared cultural heritage.",
                            "Middle Eastern literature is diverse and reflects the cultures and traditions of the region. One of the most famous works of Middle Eastern literature is One Thousand and One Nights, also known as Arabian Nights. This collection of stories and folktales has been translated into many languages and is enjoyed by people all over the world. The works of Rumi, a 13th-century Persian poet, are also widely read and admired. Rumi's poetry is known for its spiritual and philosophical themes, and has influenced many writers and thinkers throughout history. Naguib Mahfouz, an Egyptian author, is another well-known figure in Middle Eastern literature. He won the Nobel Prize in Literature in 1988 for his works that explored the complexities of Egyptian society and culture. Middle Eastern literature is an important part of the region's cultural heritage and continues to inspire and captivate readers around the world.",
                            "The Middle East is home to many famous landmarks that are renowned for their beauty and cultural significance. One of the most well-known landmarks is the Pyramids of Giza, located in Egypt. These ancient structures were built over 4,500 years ago and are a testament to the ingenuity of the ancient Egyptians. Another famous landmark is Petra, located in Jordan. This ancient city is carved into the rock and was once a thriving trading center. The city's most famous structure is the Treasury, which is carved into a towering rock face. The Alhambra, located in Granada, Spain, is also a famous Middle Eastern landmark. This palace and fortress complex was built by the Moors in the 14th century and is renowned for its intricate tile work and decorative carvings.",
                            "Middle Eastern art and architecture have a rich and complex history. Islamic art, in particular, is known for its intricate geometric patterns and calligraphy. Many mosques and other buildings feature these designs, which are meant to represent the unity and beauty of God's creation. In addition to Islamic art, the region is also known for its ancient architecture, such as the pyramids in Egypt and the ruins of Petra in Jordan. These structures are testaments to the skill and ingenuity of the region's ancient peoples. Today, modern Middle Eastern art and architecture continue to evolve, incorporating both traditional and contemporary elements.",
                            "Hospitality is an important part of Middle Eastern culture. It is customary for hosts to greet their guests with warmth and generosity. Guests are often served traditional foods and beverages, and are made to feel welcome in the host's home. In some cases, it is even considered rude to refuse an offer of food or drink. This tradition of hospitality extends beyond the home and into public spaces. Visitors to the Middle East can expect to be greeted with kindness and respect wherever they go. In fact, hospitality is often seen as a way of expressing the region's values of community and generosity.",
                        ]), unlocked: false),
                Level("Level Three", index: 2, subTitle: "A1 - A2", icon: levelThreeIcon, readings:
                        Reading([
                            "The Gulf region is home to a rich and diverse culture. It is characterized by strong family values, respect for elders, and a deep appreciation for tradition. Gulf citizens take pride in their heritage and are known for their hospitality and generosity. It is customary for guests to be served traditional foods and beverages, and to be made to feel welcome in the host's home. In addition, Gulf citizens often dress in traditional clothing, such as the thobe and the kandora, to express their cultural identity. The region is also known for its music, dance, and art, which reflect the unique authentic Arab influence that has shaped Gulf culture.",
                            "The Gulf region has made significant strides in developing its education system in recent years. All Gulf countries provide free education to their citizens, from primary school to university level. The curriculum is often based on Islamic values and emphasizes the importance of traditional subjects, such as math, science, and Arabic language. In addition, many Gulf countries have established partnerships with universities and institutions around the world to provide their students with access to a broader range of educational opportunities. The region is also home to many prestigious international schools, which cater to the needs of expatriate families living in the Gulf.",
                            "The Gulf region is known for its thriving business and economy, fueled by its abundant oil reserves and strategic location. Many Gulf countries have invested heavily in infrastructure, technology, and innovation, attracting international companies and investors. The region is also home to some of the world's largest and most successful airlines, including Emirates, Qatar Airways, and Etihad Airways. Gulf citizens are known for their entrepreneurial spirit, and many have established successful businesses across a range of industries, including finance, healthcare, and technology. The Gulf Cooperation Council (GCC) is a regional organization that promotes economic cooperation and integration among its member countries.",
                            "The Gulf region is renowned for its unique and diverse environment, characterized by its deserts, coastline, and marine life. Gulf citizens are increasingly aware of the importance of preserving and protecting their natural resources for future generations. Many Gulf countries have taken steps to promote sustainable development, including investing in renewable energy, conservation efforts, and eco-tourism. The region is also home to several wildlife reserves and national parks, which offer visitors the chance to experience the beauty and diversity of Gulf flora and fauna. Gulf citizens are committed to ensuring a sustainable future for their region, and are actively engaged in initiatives and programs that promote environmental conservation and awareness.",
                            "Saudi Arabian architecture is a blend of traditional and modern influences. Islamic architecture is particularly prominent, with many mosques and palaces featuring intricate geometric designs and calligraphy. The use of local materials such as sandstone and coral gives these buildings a unique character that is distinctly Saudi. In recent years, the country has embarked on an ambitious plan to modernize its cities, with many new skyscrapers and high-tech buildings being constructed. However, the government has also taken steps to preserve its historic architecture, such as the restoration of the Al-Turaif district in Riyadh, a UNESCO World Heritage site.",
                        ]), unlocked: false),
                Level("Level Four", index: 3, subTitle: "A1 - A2", icon: levelFourIcon, readings:
                        Reading([
                            "The Hajj pilgrimage to Mecca is one of the most important religious rituals in Islam. Every year, millions of Muslims from around the world make the journey to Mecca to perform the Hajj, which involves a series of rituals and prayers. The Hajj is a deeply spiritual experience that is intended to bring Muslims closer to Allah and strengthen their faith. The pilgrimage is also a time of great social and cultural significance, as Muslims from different countries and cultures come together to worship and share in a common experience.",
                            "Saudi Arabia's National Day is celebrated on September 23rd each year, in honor of the country's founding in 1932. The day is marked by parades, fireworks, and other festive events throughout the country. It is a time for Saudis to come together to celebrate their national identity and pride in their country's achievements. The national flag, which features the Shahada (Islamic declaration of faith) and two swords, is displayed prominently during the celebrations. The day also provides an opportunity for Saudis to reflect on their country's past and look forward to its future.",
                            "The Arabian horse is a breed of horse that originated in the Arabian Peninsula. It is known for its beauty, agility, and intelligence, and has been prized by horse enthusiasts for centuries. Arabian horses have a distinctive appearance, with a dished profile, high-set tail, and finely chiseled head. They are also known for their endurance and have been used for long-distance travel and in battle throughout history. In Saudi Arabia, the Arabian horse is a symbol of national pride and is often featured in cultural events and festivals.",
                            "The date palm is a plant that is native to the Middle East, including Saudi Arabia. It is an important part of the region's culture and economy, with dates being used in a variety of foods and products. The date palm is also highly valued for its medicinal properties, and its leaves and branches are used in traditional medicine. In addition to its practical uses, the date palm is also an important cultural symbol in Saudi Arabia and is featured in artwork, literature, and music.",
                            "The traditional souq, or market, is a common feature of cities and towns throughout the Middle East, including Saudi Arabia. It is a bustling hub of activity, where vendors sell a variety of goods such as spices, textiles, and handicrafts. In addition to being a place to shop, the souq is also an important social gathering place, where people come to meet friends and enjoy traditional foods and drinks. The souq is a vibrant part of Saudi Arabian culture and is often featured in tourist promotions and cultural events."
                        ]), unlocked: false)
            ]
            
        case "B1 - B2":
            return [
                Level("Level One", index: 0, subTitle: "B1 - B2", icon: levelOneIcon, readings:
                        Reading([
                            "Technology has had a profound impact on Saudi society in recent years. The widespread use of smartphones and social media platforms has transformed the way people communicate and interact with one another. While technology has brought many benefits, such as increased connectivity and access to information, it has also presented challenges. For example, social media can be a source of misinformation and can contribute to the spread of harmful rumors. In addition, the use of technology has raised concerns about privacy and security. As Saudi Arabia continues to develop its technology sector, it will be important to find ways to balance the benefits of technology with the need to protect individuals and society as a whole.",
                            "Saudi Arabia's Vision 2030 is an ambitious plan to transform the country's economy and society. The plan seeks to diversify the economy, reduce reliance on oil exports, and promote private sector growth. It also includes measures to improve education, healthcare, and infrastructure, and to promote tourism and cultural development. While the plan faces significant challenges, including the need to create jobs for a growing population, it represents a bold vision for Saudi Arabia's future. Success in implementing the plan will require strong leadership, innovative thinking, and a commitment to collaboration and partnership between government, business, and civil society.",
                            "Saudi Arabia has a rich and diverse cultural heritage, which is reflected in its art, music, literature, and architecture. The country is home to many historic sites and landmarks, including the ancient city of Mada'in Saleh and the Al-Ula region, which is known for its stunning rock formations and historic ruins. Preserving and promoting Saudi Arabia's cultural heritage is an important priority for the country, as it provides a link to the past and helps to define the national identity. The government has made significant investments in the preservation and restoration of historic sites and landmarks, as well as in the promotion of cultural activities and events. The cultural heritage of Saudi Arabia is a source of pride for its people and represents an important aspect of the country's identity.",
                            "Climate change is having a significant impact on Saudi Arabia, with rising temperatures and changing weather patterns affecting the country's economy and society. The country is one of the largest producers of oil and gas in the world, and the dependence on fossil fuels has contributed to the problem of greenhouse gas emissions. The government has implemented a range of measures to address the impact of climate change, including investing in renewable energy sources and reducing the country's reliance on fossil fuels. However, there are also challenges to be overcome, including the need to balance economic development with environmental protection and the need for international cooperation to address the global nature of the problem. Climate change represents a significant challenge for Saudi Arabia, but it also provides an opportunity to transition to a more sustainable and resilient economy.",
                            "Bilingualism, the ability to speak two languages fluently, has many benefits. Studies have shown that bilingual individuals have better cognitive skills, including improved problem-solving abilities and enhanced creativity. Bilingualism can also lead to improved job prospects, as many employers value employees who can speak multiple languages. Additionally, being bilingual can help individuals connect with people from different cultures and make travel more enjoyable. Learning a second language may take time and effort, but the benefits are well worth it.",
                        ]), unlocked: true),
                Level("Level Two", index: 1, subTitle: "B1 - B2", icon: levelTwoIcon, readings:
                        Reading([
                            "Happiness is a complex emotion that is influenced by a variety of factors, including genetics, life circumstances, and personal choices. Positive psychology is a field that focuses on the study of happiness and well-being, and researchers have identified a range of strategies that can increase feelings of happiness and life satisfaction. These strategies include cultivating positive relationships, practicing gratitude, engaging in meaningful activities, and prioritizing self-care. While happiness is a subjective experience, there are evidence-based practices that can help individuals increase their overall sense of well-being.",
                            "Animal testing has been a controversial issue for many years, with advocates arguing that it is necessary for medical research and opponents arguing that it is cruel and unnecessary. While animal testing has contributed to important medical discoveries, such as the development of vaccines and the treatment of diseases, there are also concerns about the ethical implications of using animals for scientific purposes. Alternative methods, such as computer modeling and in vitro testing, are being developed to reduce the need for animal testing. However, there is still much debate about the use of animals in scientific research, and it is important to weigh the potential benefits against the ethical considerations.",
                            "The role of women in politics has been a topic of much discussion and debate in recent years. While women have made significant strides in the political sphere, with many countries now having female heads of state or government, there is still much work to be done to achieve gender equality in politics. Women face a range of barriers to political participation, including gender stereotypes, discrimination, and harassment. Efforts to increase the representation of women in politics include measures such as affirmative action, quotas, and increased support for women's political campaigns. The full participation of women in politics is essential for achieving true democracy and inclusive governance.",
                            "Genetic engineering is the process of manipulating the DNA of living organisms to create desired traits. While this technology has the potential to revolutionize fields such as medicine and agriculture, there are also ethical concerns surrounding its use. For example, there are concerns about the unintended consequences of genetically modifying organisms and the potential for discrimination based on genetic traits. As genetic engineering continues to advance, it will be important for society to have a dialogue about its ethical implications and to develop guidelines for its responsible use.",
                            "Space exploration has captured the imaginations of people around the world for decades. As technology continues to advance, there are new possibilities for exploring our solar system and beyond. However, space exploration is also a complex and expensive endeavor that requires significant resources and planning. As space agencies and private companies look to the future of space exploration, they must consider questions such as how to make space travel more sustainable, how to ensure the safety of astronauts, and how to allocate resources fairly. The future of space exploration holds both promise and challenges, and it will require collaboration and innovation to achieve its full potential."]), unlocked: false),
                Level("Level Three", index: 2, subTitle: "B1 - B2", icon: levelThreeIcon, readings:
                        Reading([
                            "Globalization is the process by which economies, societies, and cultures become increasingly interconnected. While globalization has brought many benefits, such as increased trade and cultural exchange, it has also had significant impacts on the world's economies and societies. For example, there are concerns about the exploitation of workers in developing countries, the loss of jobs in developed countries, and the impact of globalization on cultural traditions. As globalization continues to shape our world, it will be important for society to address these challenges and to find ways to harness the positive aspects of globalization while minimizing its negative impacts.",
                            "Artificial intelligence (AI) has the potential to revolutionize industries in Saudi Arabia, from healthcare to finance to logistics. The country has set ambitious goals to become a leader in AI development, with investments being made in research and development, education and training, and infrastructure. The use of AI has already shown promising results in areas such as predictive maintenance, customer service, and fraud detection. However, there are also concerns about the impact of AI on employment and the need for regulation to ensure that its development is ethical and transparent. As the use of AI continues to grow, it will be important for Saudi Arabia to balance the benefits of the technology with the potential challenges.",
                            "Cultural diplomacy is the practice of using cultural exchanges, events, and programs to promote understanding and cooperation between countries. Saudi Arabia has recognized the importance of cultural diplomacy in building relationships with other countries and promoting its cultural heritage. Initiatives such as the Saudi Cultural Attaché program and the annual Janadriyah festival showcase Saudi Arabia's rich cultural heritage and traditions. Cultural diplomacy can also contribute to economic development and enhance the country's soft power. However, there are challenges to be overcome, including ensuring that cultural exchanges are respectful and representational, and promoting cultural understanding in a globalized world.",
                            "Women's participation in the workforce has been identified as a key driver of economic growth in Saudi Arabia. The country has set ambitious goals to increase the participation of women in the workforce, including the introduction of policies such as the lifting of the ban on women driving and the establishment of female-only industrial zones. Women have also been encouraged to pursue careers in fields such as science, technology, engineering, and mathematics (STEM). Increasing women's participation in the workforce is a complex challenge that will require a range of policy measures and social changes.",
                            "As one of the world's largest oil producers, Saudi Arabia has historically relied on fossil fuels to power its economy. However, the country is now looking to diversify its energy mix and invest in renewable sources of energy. Saudi Arabia has set an ambitious goal to produce 50% of its energy from renewable sources by 2030, and the government has launched several initiatives to support the development of renewable energy projects. These initiatives include the construction of large-scale solar and wind farms and the introduction of regulations to encourage the use of renewable energy. As the world shifts towards cleaner and more sustainable energy sources, Saudi Arabia is poised to play a leading role in the development of renewable energy technology."
                        ]), unlocked: false),
                Level("Level Four", index: 3, subTitle: "B1 - B2", icon: levelFourIcon, readings:
                        Reading([
                            "Artificial intelligence (AI) has the potential to transform many aspects of the labor market, from automating routine tasks to creating new jobs that require specialized skills. While AI has the potential to bring many benefits, there are also concerns about its impact on employment. Some experts predict that AI could lead to widespread job losses as machines take over tasks that were previously performed by humans. However, others argue that AI will create new job opportunities in areas such as data analysis, software development, and robotics. As AI continues to evolve, it will be important for policymakers and businesses to consider the potential impact on the labor market and to develop strategies to ensure that the benefits of AI are shared equitably.",
                            "E-commerce has seen significant growth in Saudi Arabia in recent years, driven by increasing internet penetration and a growing consumer base. Online shopping offers convenience, choice, and competitive prices, and it has become an increasingly popular option for Saudis. Major global e-commerce companies such as Amazon and Noon have established a presence in the Saudi market, and local e-commerce platforms such as Souq and Salla have also emerged. The government has introduced regulations to support the growth of e-commerce, including the establishment of an electronic payment system and the introduction of regulations to protect consumers. As e-commerce continues to grow in Saudi Arabia, it is expected to play an increasingly important role in the country's economy and society.",
                            "Renewable energy is becoming increasingly important as countries seek to reduce their reliance on fossil fuels and address the challenge of climate change. Renewable energy sources such as solar and wind power are becoming more cost-competitive with traditional energy sources, and technological advances are making them more efficient and reliable. Many countries are setting ambitious goals for increasing the share of renewable energy in their energy mix. However, there are also challenges to be overcome, such as the need for energy storage solutions and the need to integrate renewable energy sources into existing energy systems. The transition to renewable energy represents a significant global trend that will have far-reaching impacts on the economy, society, and the environment.",
                            "The world of work is undergoing significant changes due to technological advances and shifting global trends. Automation and artificial intelligence are transforming many industries and occupations, leading to both opportunities and challenges for workers. The rise of the gig economy and remote work are changing the way that people work and interact with each other. The COVID-19 pandemic has accelerated these trends, with many companies adopting new ways of working that are likely to persist in the post-pandemic world. As the nature of work continues to evolve, it will be important for workers to develop new skills and adapt to new working conditions.",
                            "Globalization refers to the interconnectedness of the world economy and society, facilitated by advances in transportation, communication, and technology. Globalization has brought many benefits, such as increased trade and investment, cultural exchange, and access to new markets and technologies. However, it has also brought challenges, such as economic inequality, cultural homogenization, and environmental degradation. The COVID-19 pandemic has exposed some of the vulnerabilities of a globalized world, such as the fragility of supply chains and the importance of international cooperation in responding to global crises. As the world becomes increasingly interconnected, it will be important to ensure that the benefits of globalization are shared fairly and that the negative impacts are minimized."
                        ]), unlocked: false)
            ]
        case "C1 - C2":
            return [
                Level("Level One", index: 0, subTitle: "C1 - C2", icon: levelOneIcon, readings:
                        Reading([
                            "Climate change is having a profound impact on global food systems. Extreme weather events, such as droughts and floods, are becoming more frequent and severe, leading to crop failures and food shortages in many parts of the world. Rising temperatures are also affecting the productivity of crops, reducing yields and nutritional value. The impacts of climate change on food systems are not limited to agriculture, as changes in marine ecosystems are also affecting fish populations and the livelihoods of millions of people who depend on them. Addressing the impacts of climate change on global food systems will require concerted action at the international level, including investment in climate-resilient agriculture and fisheries, as well as efforts to reduce greenhouse gas emissions.",
                            "Advances in gene editing technology, such as CRISPR-Cas9, have opened up new possibilities for treating genetic diseases and improving human health. However, the use of gene editing raises important ethical questions. For example, should gene editing be used to enhance human traits, such as intelligence or athleticism? Who should have access to these technologies, and how should they be regulated? There are also concerns about the unintended consequences of gene editing, such as off-target effects that could cause harm to the individual or their offspring. As with any emerging technology, it is important to consider the potential risks and benefits of gene editing and to ensure that its use is guided by ethical principles and values.",
                            "Quantum computing is an emerging technology that has the potential to revolutionize computing as we know it. Unlike classical computers, which process information in binary bits, quantum computers use quantum bits, or qubits, which can exist in multiple states simultaneously. This allows quantum computers to perform complex calculations much faster than classical computers. However, there are still significant challenges to be overcome before quantum computing becomes a practical tool. One of the biggest challenges is developing error correction techniques that can protect quantum computations from the effects of noise and interference. Nevertheless, the potential of quantum computing is so great that researchers and companies around the world are investing heavily in this field.",
                            "The COVID-19 pandemic has had a profound impact on global health and wellbeing. As the virus continues to spread around the world, it has exposed deep inequalities in access to healthcare and highlighted the need for international cooperation to address global health threats. In addition to the direct health impacts of the virus, there are also significant economic and social implications, including disruptions to supply chains, job losses, and increased poverty. As we work to address the ongoing pandemic, it is important to consider the lessons learned and to invest in measures to strengthen healthcare systems and address the underlying social and economic factors that contribute to poor health outcomes.",
                            "Bibliographies, or lists of references cited in a research paper or book, are a crucial component of scholarly work. By providing a comprehensive list of sources, bibliographies allow readers to evaluate the quality and credibility of the research presented, and to locate additional sources for further study. In addition to serving as a tool for readers, bibliographies are also an important part of the research process itself, helping scholars to track their sources and ensure the accuracy and completeness of their work. As we continue to produce and consume ever-increasing amounts of information, the importance of bibliographies as a tool for organizing and sharing knowledge has only grown.",
                        ]), unlocked: true),
                Level("Level Two", index: 1, subTitle: "C1 - C2", icon: levelTwoIcon, readings:
                        Reading([
                            "Nature is a source of inspiration and wonder for people around the world. From the majesty of mountains to the diversity of animal and plant life, the natural world is full of beauty and complexity. At the same time, the natural world is also under threat from a range of human activities, from climate change to habitat destruction. As we work to address these challenges, it is important to remember the value and importance of nature in our lives. Whether through conservation efforts, scientific research, or simply spending time in nature, we can all contribute to a more sustainable and harmonious relationship between humans and the natural world.",
                            "Astronomers have long been fascinated by the mysteries of the universe, and recent research has shed new light on one of the most intriguing questions of all: what is the fate of the universe? The discovery of dark energy, a mysterious force that appears to be accelerating the expansion of the universe, has led scientists to rethink our understanding of the cosmos. By studying the behavior of distant galaxies and the cosmic microwave background radiation, astronomers are working to unlock the secrets of dark energy and its impact on the fate of the universe.",
                            "As the world continues to grapple with the urgent challenge of climate change, economists are increasingly focused on the role of markets in promoting environmental sustainability. From carbon pricing to green bonds, a range of new financial instruments are emerging to incentivize investment in renewable energy and other low-carbon technologies. At the same time, economists are also working to incorporate the value of natural resources and ecosystem services into economic models, in order to better account for the costs and benefits of environmental policy. By bringing together the tools of economics and environmental science, we can work towards a more sustainable and prosperous future for all.",
                            "As the world continues to grapple with the urgent challenge of climate change, economists are increasingly focused on the role of markets in promoting environmental sustainability. From carbon pricing to green bonds, a range of new financial instruments are emerging to incentivize investment in renewable energy and other low-carbon technologies. At the same time, economists are also working to incorporate the value of natural resources and ecosystem services into economic models, in order to better account for the costs and benefits of environmental policy. By bringing together the tools of economics and environmental science, we can work towards a more sustainable and prosperous future for all.",
                            "While precision and clarity are often prized in academic writing and technical communication, vague language can be a powerful tool in literature. By leaving gaps and uncertainties in their work, writers can invite readers to actively participate in the process of interpretation, creating a sense of intimacy and engagement between reader and text. Vague language can also be used to capture the complexity and nuance of human experience, reflecting the ways in which our thoughts and emotions are often imprecise and difficult to articulate. From the enigmatic poetry of Emily Dickinson to the open-ended narratives of Samuel Beckett, vague language has played an important role in some of the most innovative and influential works of literature."
                        ]), unlocked: false),
                Level("Level Three", index: 2, subTitle: "C1 - C2", icon: levelThreeIcon, readings:
                        Reading([
                            "In the complex and ever-changing world of business, the pursuit of profit can sometimes come into conflict with ethical considerations. From the exploitation of workers to the destruction of the environment, the pursuit of profit has been implicated in a wide range of social and environmental problems. At the same time, many businesses are recognizing the value of ethical practices in building long-term relationships with customers, employees, and stakeholders. By prioritizing transparency, accountability, and social responsibility, businesses can create value not only for shareholders, but also for society as a whole.",
                            "Technology has revolutionized the way we consume and produce news and information. From social media algorithms to automated news feeds, technology has transformed the way we access and share information, and has created new opportunities for citizen journalism and grassroots activism. At the same time, technology has also raised important questions about the quality and reliability of news and information, and has been implicated in the spread of misinformation and propaganda. As we navigate the complex and rapidly changing landscape of news and current affairs, it is important to critically evaluate the role of technology in shaping our understanding of the world around us, and to work towards a future in which technology is used to support a more informed and engaged public.",
                            "The pursuit of profit has long been a driving force in business, but in recent years, there has been a growing recognition of the importance of ethical considerations in business practices. From fair labor practices to environmental sustainability, businesses are increasingly expected to operate with transparency, accountability, and social responsibility. The ethical challenges facing businesses today are complex and multifaceted, and require a nuanced approach that balances the needs of stakeholders, shareholders, and society as a whole.",
                            "From the discovery of antibiotics to the development of artificial intelligence, scientific breakthroughs have transformed every aspect of modern life. While these developments have brought about tremendous benefits, they have also raised important ethical questions and social challenges. The rapid pace of technological change has left many feeling uncertain and anxious about the future, and has highlighted the need for careful consideration of the potential impacts of scientific developments on society. As we move into an increasingly technological future, it is important to engage in thoughtful dialogue and ethical reflection on the role of science in shaping the world around us.",
                            "Books and literature have long been celebrated for their ability to transport readers to new worlds and engage them in complex and thought-provoking narratives. At the heart of this power is the art of storytelling, the ability of writers to craft compelling characters, build suspense, and weave together themes and motifs that resonate with readers on a deep and emotional level. From the sweeping epic novels of Tolstoy and Dickens to the experimental narratives of Virginia Woolf and James Joyce, literature continues to challenge and inspire readers with its unparalleled ability to capture the beauty and complexity of the human experience."
                        ]), unlocked: false),
                Level("Level Four", index: 3, subTitle: "C1 - C2", icon: levelFourIcon, readings:
                        Reading([
                            "As the world becomes increasingly interconnected and globalized, the traditional boundaries between money and business are rapidly eroding. The rise of digital technologies, from cryptocurrency to online marketplaces, has created new opportunities for entrepreneurs and investors alike, while also raising important questions about the future of work, privacy, and regulation. At the same time, businesses are increasingly recognizing the importance of social responsibility and sustainability, as consumers demand greater transparency and accountability from the companies they support. In this rapidly evolving landscape, the role of money and business in shaping our society and economy has never been more important.",
                            "From breakthroughs in gene editing to the development of quantum computing, scientific advances are rapidly transforming our understanding of the world around us and opening up new possibilities for the future of humanity. At the same time, these developments raise important ethical and philosophical questions about the limits of human knowledge and the role of science in shaping our collective destiny. As we grapple with these profound and often unsettling questions, it is more important than ever to foster a deep and nuanced understanding of the scientific process and the impact of scientific developments on our lives and the world around us.",
                            "In an era of 24-hour news cycles and social media feeds, the role of news and current affairs has never been more important or more fraught. On the one hand, access to timely and reliable information is essential for informed citizenship and democratic participation. On the other hand, the spread of fake news and the rise of polarization and extremism highlight the dangers of misinformation and propaganda. As we navigate this complex and rapidly changing media landscape, it is crucial to develop critical thinking skills and media literacy, and to engage in active and informed dialogue about the issues that matter most to us.",
                            "While precision and clarity are often prized in academic writing and technical communication, vague language can be a powerful tool in literature. By leaving gaps and uncertainties in their work, writers can invite readers to actively participate in the process of interpretation, creating a sense of intimacy and engagement between reader and text. Vague language can also be used to capture the complexity and nuance of human experience, reflecting the ways in which our thoughts and emotions are often imprecise and difficult to articulate. From the enigmatic poetry of Emily Dickinson to the open-ended narratives of Samuel Beckett, vague language has played an important role in some of the most innovative and influential works of literature.",
                            "Living in the fast-paced world of the 21st century, we often find ourselves caught in the never-ending cycle of work and stress. However, it is important to remember that life is not just about making a living; it is also about living a life. In fact, finding a balance between work and play is crucial for our overall well-being. Research has shown that people who prioritize leisure activities have a higher level of life satisfaction and better mental health than those who don't. However, it is not just about engaging in any activity; it is about finding activities that give us a sense of fulfillment and purpose. In order to achieve this balance, it is important to create a schedule that includes both work and leisure activities. We need to prioritize our leisure time just as much as we prioritize our work time. By doing so, we can improve our productivity, reduce stress, and enhance our quality of life."
                        ]), unlocked: false)
            ]
        default:
            return []
        }
    }
}

extension HomeViewModel {
    
    func readLevels() {
        // Read Get Data
        if let data = userDefult.data(forKey: forKey) {
            do {
                // Decode Note
                let levels = try JSONDecoder().decode([Level].self, from: data)
                DispatchQueue.main.async {
                    self.levels = levels
                }
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            saveInitLevelsSate()
        }
    }
    
    private func saveInitLevelsSate() {
        do {
            let data = try JSONEncoder().encode(level)
            // Write Data
            userDefult.set(data, forKey: forKey)
        } catch let error {
            print("Unable to Encode Note (\(error))")
        }
    }
}

// MARK: ViewModels
extension HomeViewModel {
    
    var detailsViewModel: DetailsViewModel {
        let viewModel = DetailsViewModel()
        viewModel.didUpdateLevel = { [weak self] level in
            guard let self = self else { return }
            guard let level = level else {
                print("Level is nil.")
                return
            }

            do {
                var levels = self.levels
                guard let index = levels.firstIndex(where: {
                    $0.title == level.title && $0.id == level.id && $0.readings.id == level.readings.id
                }) else {
                    print("Level not found in the list.")
                    return
                }
                
                levels[index] = level

                if level.readings.fromIndex >= 3 && index <= 2 {
                    levels[index + 1].unlocked = true
                    print("Level: \(levels[index + 1].title) - unlocked: \(levels[index + 1].unlocked)")
                }
                
                let data = try JSONEncoder().encode(levels)
                // Write Data
                self.userDefult.set(data, forKey: "levels")
            } catch {
                print("Unable to Encode Levels (\(error))")
            }
        }
        return viewModel
    }
}

// MARK: Titles
extension HomeViewModel {}

// MARK: Icons
extension HomeViewModel {
    var levelOneIcon: String { "levelOneIcon" }
    var levelTwoIcon: String { "levelTwoIcon" }
    var levelThreeIcon: String { "levelThreeIcon" }
    var levelFourIcon: String { "levelFourIcon" }
    var lockIcon: String { "lockIcon" }
    var activeLevelIcon: String { "activeLevelIcon" }
    var headerIcon: String { "headerIcon" }
    var buttonIcon: String { "buttonIcon" }
}
