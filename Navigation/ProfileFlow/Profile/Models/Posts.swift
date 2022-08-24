//
//  Posts.swift
//  Navigation
//
//  Created by Филипп Степанов on 12.09.2021.
//

import Foundation
import UIKit

public struct Posts {
    
    public var author: String
    
    public var description: String
    
    public var image: UIImage
    
    public var likes: Int
    
    public var views: Int
}

public var post1 = Posts(author: "Michael", description: "Байкал. Озеро тектонического происхождения в южной части Восточной Сибири, самое глубокое озеро на планете, крупнейший природный резервуар пресной воды и самое большое по площади пресноводное озеро на континенте.", image: UIImage(named: "Байкал")!, likes: 7777, views: 10000)

public var post2 = Posts(author: "Bill", description: "Комплекс пирамид в Гизе — комплекс древних памятников на плато Гиза в пригороде Каира, современной столицы Египта. Находится на расстоянии около 8 км по направлению в центр Ливийской пустыни от старого города Гиза на реке Нил, примерно в 25 км к юго-западу от центра Каира.", image: UIImage(named: "Пирамиды")!, likes: 11111, views: 22222)

public var post3 = Posts(author: "John", description: "Статуя Зевса в Олимпии — третье чудо света Древнего мира. Была воздвигнута в V веке до нашей эры. Она была изготовлена из золота, дерева и слоновой кости, в так называемой хрисоэлефантинной технике. Мраморный храм Зевса превосходил по размерам все существовавшие на тот момент храмы.", image: UIImage(named: "Зевс")!, likes: 3324, views: 4123452)

public var post4 = Posts(author: "Rupert", description: "Храм Артемиды Эфесской. Греческий храм, посвящённый местному культу богини Артемиды (соответствует римской богине Диане). Находился в греческом городе Эфесе на побережье Малой Азии, в настоящее время — около города Сельчук на юге провинции Измир, Турция", image: UIImage(named: "Храм")!, likes: 234324, views: 12344123)

public var posts: [Posts] = [post1, post2, post3, post4]
