//
//  Posts.swift
//  Navigation
//
//  Created by Lev on 03.05.2022.
//

import UIKit

struct Posts {
    let author: String
    let description: String
    let image: UIImage
    let likes: Int
    let views: Int
    
    static func makePost() -> [Posts] {
        var post = [Posts]()
        post.append(Posts(author: "Библиотека\nпрограммиста", description: """
🌏 ТОП-6 стран для переезда в 2022 году: советы по релокейту для айтишника
Сложная политическая и экономическая ситуация заставляет опытных специалистов задуматься об эмиграции. Делимся информацией о происходящем.

https://proglib.io/sh/TO29L0PY5K
""" , image: UIImage(named: "1")!, likes: Int.random(in: 0..<1000), views: Int.random(in: 0..<1000)))
        post.append(Posts(author: "IT mems", description: """
⚡⚡Срочные новости! У студентов из Нетологии "кипит мозг" из-за домашних заданий из модуля «iOS-dev: интерфейс приложения»
""", image: UIImage(named: "2")!, likes: Int.random(in: 0..<1000), views: Int.random(in: 0..<1000)))
        post.append(Posts(author: "Habr", description: "Как проходят майские праздники у программистов", image: UIImage(named: "3")!, likes: Int.random(in: 0..<1000), views: Int.random(in: 0..<1000)))
        post.append(Posts(author: "В офисе", description: "Прихожу в офис в понедельник и не понимаю, чем я вообще занимался на этой работе", image: UIImage(named: "4")!, likes: Int.random(in: 0..<1000), views: Int.random(in: 0..<1000)))
        return post
    }
}
