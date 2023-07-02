//
//  DetailsViewModel.swift
//  Read and Learn
//
//  Created by Mohsen Qaysi on 6/1/23.
//

import Foundation

class DetailsViewModel: ObservableObject {
    private var level: Level
    
    @Published var index = 0
    @Published var isSelected: Int?
    @Published var selectedWord = ""

    init(level: Level) {
        self.level = level
    }
}

extension DetailsViewModel {
    var maxValue: Int { max(0, readingsList.count-1) }
    
    var nextButtonTitle: String {
        return index < maxValue ? nextTitle : lastOneTitle
    }
    
    var isLastpassage: Bool {
        return index < maxValue ? false : true
    }

    var readingsList: [String] {
        return [
            "Saudi Arabian cuisine is a blend of Arabian, Persian, and Indian influences. It is known for its rich flavors and spices, as well as its use of lamb, chicken, and rice. One of the most popular dishes in Saudi Arabia is called Kabsa. This is a flavorful rice dish that is usually served with chicken or lamb. The rice is cooked with a blend of spices, including saffron, cardamom, and cinnamon. The meat is usually cooked separately and then mixed with the rice. Saudi Arabian cuisine is an important part of the country's culture and is enjoyed by locals and visitors alike.",
            "Saudi Arabia is a country rich in cultural traditions and holidays. One of the most important holidays is Eid al-Fitr, which marks the end of the month of Ramadan. During Eid al-Fitr, families gather together to celebrate with food, sweets, and gift-giving. Another important holiday is Eid al-Adha, which celebrates the end of the annual Hajj pilgrimage to Mecca. During this holiday, Muslims around the world sacrifice an animal and share the meat with their family, friends, and those in need. In addition to these religious holidays, Saudi Arabia also celebrates National Day on September 23rd. This holiday marks the day when King Abdulaziz united the country in 1932. Celebrations include parades, fireworks, and cultural events. Saudi Arabian holidays are a time for families and friends to come together and celebrate their shared heritage and traditions.",
            "Saudi Arabia is home to many famous landmarks that attract tourists from all over the world. One of the most iconic landmarks is the Kaaba, located in the city of Mecca. The Kaaba is a black cube-shaped structure that is the holiest site in Islam. It is believed to have been built by the prophet Ibrahim and is the focal point of the annual Hajj pilgrimage. Another famous landmark is the Masmak Fortress, located in the city of Riyadh. The fortress was built in the 19th century and played a crucial role in the unification of Saudi Arabia. Visitors can explore the fortress and learn about its history. Saudi Arabia's famous landmarks are a testament to the country's rich history and cultural heritage.",
            "Middle Eastern music is diverse and encompasses a wide range of styles and genres. One popular type of music is called oud music, which is played on a stringed instrument called an oud. The oud has a unique sound and is often used in both classical and contemporary Middle Eastern music. Another popular style of music is called belly dance music, which is often played during traditional belly dancing performances. This music is characterized by its rhythmic beats and use of instruments like the tambourine and finger cymbals. Middle Eastern music has a long history and is an important part of the region's cultural heritage.",
            "Middle Eastern clothing varies from country to country, but there are some common styles and designs that can be found throughout the region. One traditional garment for men is the thobe, which is a long robe-like garment that is often worn for special occasions. Women's clothing also includes a long garment called an abaya, which covers the entire body except for the face, hands, and feet. Hijab is a head covering that is worn by many Muslim women as a sign of modesty and religious observance. Middle Eastern clothing is often made from light, flowing fabrics like cotton and silk, which help to keep the wearer cool in the hot climate. Traditional clothing is an important part of Middle Eastern culture and is often worn during religious festivals and other special occasions.",
            "Sports are an important part of Middle Eastern culture and include a wide range of activities. One popular sport is football (soccer), which is played throughout the region and has a large following. Camel racing is also a traditional sport that is still practised in some parts of the region. In addition to team sports, there are also individual sports like boxing and wrestling that are popular. Many Middle Eastern countries also have their own traditional sports, such as kabaddi in Iran and jereed in Saudi Arabia. Sports are an important way for people to come together and celebrate their shared cultural heritage.",
            "Middle Eastern literature is diverse and reflects the cultures and traditions of the region. One of the most famous works of Middle Eastern literature is One Thousand and One Nights, also known as Arabian Nights. This collection of stories and folktales has been translated into many languages and is enjoyed by people all over the world. The works of Rumi, a 13th-century Persian poet, are also widely read and admired. Rumi's poetry is known for its spiritual and philosophical themes, and has influenced many writers and thinkers throughout history. Naguib Mahfouz, an Egyptian author, is another well-known figure in Middle Eastern literature. He won the Nobel Prize in Literature in 1988 for his works that explored the complexities of Egyptian society and culture. Middle Eastern literature is an important part of the region's cultural heritage and continues to inspire and captivate readers around the world.",
            "The Middle East is home to many famous landmarks that are renowned for their beauty and cultural significance. One of the most well-known landmarks is the Pyramids of Giza, located in Egypt. These ancient structures were built over 4,500 years ago and are a testament to the ingenuity of the ancient Egyptians. Another famous landmark is Petra, located in Jordan. This ancient city is carved into the rock and was once a thriving trading center. The city's most famous structure is the Treasury, which is carved into a towering rock face. The Alhambra, located in Granada, Spain, is also a famous Middle Eastern landmark. This palace and fortress complex was built by the Moors in the 14th century and is renowned for its intricate tile work and decorative carvings.",
            "Middle Eastern art and architecture have a rich and complex history. Islamic art, in particular, is known for its intricate geometric patterns and calligraphy. Many mosques and other buildings feature these designs, which are meant to represent the unity and beauty of God's creation. In addition to Islamic art, the region is also known for its ancient architecture, such as the pyramids in Egypt and the ruins of Petra in Jordan. These structures are testaments to the skill and ingenuity of the region's ancient peoples. Today, modern Middle Eastern art and architecture continue to evolve, incorporating both traditional and contemporary elements.",
            "Hospitality is an important part of Middle Eastern culture. It is customary for hosts to greet their guests with warmth and generosity. Guests are often served traditional foods and beverages, and are made to feel welcome in the host's home. In some cases, it is even considered rude to refuse an offer of food or drink. This tradition of hospitality extends beyond the home and into public spaces. Visitors to the Middle East can expect to be greeted with kindness and respect wherever they go. In fact, hospitality is often seen as a way of expressing the region's values of community and generosity.",
            "The Gulf region is home to a rich and diverse culture. It is characterized by strong family values, respect for elders, and a deep appreciation for tradition. Gulf citizens take pride in their heritage and are known for their hospitality and generosity. It is customary for guests to be served traditional foods and beverages, and to be made to feel welcome in the host's home. In addition, Gulf citizens often dress in traditional clothing, such as the thobe and the kandora, to express their cultural identity. The region is also known for its music, dance, and art, which reflect the unique authentic Arab influence that has shaped Gulf culture.",
            "The Gulf region has made significant strides in developing its education system in recent years. All Gulf countries provide free education to their citizens, from primary school to university level. The curriculum is often based on Islamic values and emphasizes the importance of traditional subjects, such as math, science, and Arabic language. In addition, many Gulf countries have established partnerships with universities and institutions around the world to provide their students with access to a broader range of educational opportunities. The region is also home to many prestigious international schools, which cater to the needs of expatriate families living in the Gulf.",
            "The Gulf region is known for its thriving business and economy, fueled by its abundant oil reserves and strategic location. Many Gulf countries have invested heavily in infrastructure, technology, and innovation, attracting international companies and investors. The region is also home to some of the world's largest and most successful airlines, including Emirates, Qatar Airways, and Etihad Airways. Gulf citizens are known for their entrepreneurial spirit, and many have established successful businesses across a range of industries, including finance, healthcare, and technology. The Gulf Cooperation Council (GCC) is a regional organization that promotes economic cooperation and integration among its member countries.",
            "The Gulf region is renowned for its unique and diverse environment, characterized by its deserts, coastline, and marine life. Gulf citizens are increasingly aware of the importance of preserving and protecting their natural resources for future generations. Many Gulf countries have taken steps to promote sustainable development, including investing in renewable energy, conservation efforts, and eco-tourism. The region is also home to several wildlife reserves and national parks, which offer visitors the chance to experience the beauty and diversity of Gulf flora and fauna. Gulf citizens are committed to ensuring a sustainable future for their region, and are actively engaged in initiatives and programs that promote environmental conservation and awareness.",
            "Saudi Arabian architecture is a blend of traditional and modern influences. Islamic architecture is particularly prominent, with many mosques and palaces featuring intricate geometric designs and calligraphy. The use of local materials such as sandstone and coral gives these buildings a unique character that is distinctly Saudi. In recent years, the country has embarked on an ambitious plan to modernize its cities, with many new skyscrapers and high-tech buildings being constructed. However, the government has also taken steps to preserve its historic architecture, such as the restoration of the Al-Turaif district in Riyadh, a UNESCO World Heritage site.",
            "The Hajj pilgrimage to Mecca is one of the most important religious rituals in Islam. Every year, millions of Muslims from around the world make the journey to Mecca to perform the Hajj, which involves a series of rituals and prayers. The Hajj is a deeply spiritual experience that is intended to bring Muslims closer to Allah and strengthen their faith. The pilgrimage is also a time of great social and cultural significance, as Muslims from different countries and cultures come together to worship and share in a common experience.",
            "Saudi Arabia's National Day is celebrated on September 23rd each year, in honor of the country's founding in 1932. The day is marked by parades, fireworks, and other festive events throughout the country. It is a time for Saudis to come together to celebrate their national identity and pride in their country's achievements. The national flag, which features the Shahada (Islamic declaration of faith) and two swords, is displayed prominently during the celebrations. The day also provides an opportunity for Saudis to reflect on their country's past and look forward to its future.",
            "The Arabian horse is a breed of horse that originated in the Arabian Peninsula. It is known for its beauty, agility, and intelligence, and has been prized by horse enthusiasts for centuries. Arabian horses have a distinctive appearance, with a dished profile, high-set tail, and finely chiseled head. They are also known for their endurance and have been used for long-distance travel and in battle throughout history. In Saudi Arabia, the Arabian horse is a symbol of national pride and is often featured in cultural events and festivals.",
            "The date palm is a plant that is native to the Middle East, including Saudi Arabia. It is an important part of the region's culture and economy, with dates being used in a variety of foods and products. The date palm is also highly valued for its medicinal properties, and its leaves and branches are used in traditional medicine. In addition to its practical uses, the date palm is also an important cultural symbol in Saudi Arabia and is featured in artwork, literature, and music.",
            "The traditional souq, or market, is a common feature of cities and towns throughout the Middle East, including Saudi Arabia. It is a bustling hub of activity, where vendors sell a variety of goods such as spices, textiles, and handicrafts. In addition to being a place to shop, the souq is also an important social gathering place, where people come to meet friends and enjoy traditional foods and drinks. The souq is a vibrant part of Saudi Arabian culture and is often featured in tourist promotions and cultural events."
        ]
    }
    
    var title: String {
        return level.title
    }
    
    var subTitle: String {
        return level.subTitle
    }
    
    var icon: String {
        return level.icon
    }
    
    var isUnlocked: Bool {
        return level.unlocked
    }
}


// MARK: Titles
extension DetailsViewModel {
    var checkTitle: String { "Check" }
    var nextTitle: String { "next" }
    var lastOneTitle: String { "Last One" }

}

// MARK: Icons
extension DetailsViewModel {
    var headerIcon: String { "headerIcon" }
    var buttonIcon: String { "buttonIcon" }
    var recordButtonIcon: String { "recordButtonIcon" }
}
