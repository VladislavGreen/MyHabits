//
//  InfoData.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/27/22.
//


    
    let title = "Привычка за 21 день \n"
    let subTitle = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
    let text01 = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
    let text02 = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
    let text03 = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться."
    let text04 = "4. Поздравить себя с прохождением первого серьезного порога в 21 день.За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."
    let text05 = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой."
    let text06 = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."

struct InfoData {
    static var text: [Int: String] = [
        -1: title,
        0: subTitle,
        1: text01,
        2: text02,
        3: text03,
        4: text04,
        5: text05,
        6: text06
    ]
}
