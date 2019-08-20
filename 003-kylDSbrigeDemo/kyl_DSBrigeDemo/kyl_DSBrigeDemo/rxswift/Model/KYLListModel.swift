//
//  KYLListModel.swift
//  kyl_DSBrigeDemo
//
//  Created by yulu kong on 2019/8/20.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import HandyJSON
import RxDataSources
import Differentiator


class KModel: HandyJSON {
    var name:String = ""
    var iconPath:String = ""
    var className:String = ""
    
    required init() {}
}

struct KSectionModel {
    let name:String
    let gitHubID:String
    var image:UIImage?
    
    init(name:String,gitHubID:String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }

}

struct KSectionDataModel {
    var kheader:Identify
    var items:[Item]
}

extension KSectionDataModel:SectionModelType {
    typealias Item = KSectionModel
    typealias Identify = String
    
    var identity: Identify {
        return kheader
    }
    
    init(original: KSectionDataModel, items: [Item]) {
        self = original
        self.items = items
    }
}



class KSectionGithubData {
    let sectionData = Observable.just([
        KSectionDataModel(kheader: "A", items: [
            KSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        KSectionDataModel(kheader: "B", items: [
            KSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ])
        ])
}


class KGithubData {
    var githubData: Observable<[SectionModel<String, KSectionModel>]> {
        get {
            return Observable.just(githubArray)
        }
    }
    
    let githubArray = [
        SectionModel(model: "A", items: [
            KSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        SectionModel(model: "B", items: [
            KSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ]),
        SectionModel(model: "C", items: [
            KSectionModel(name: "Carlos García", gitHubID: "carlosypunto"),
            KSectionModel(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
            KSectionModel(name: "Chris Jimenez", gitHubID: "PiXeL16"),
            KSectionModel(name: "Christian Tietze", gitHubID: "DivineDominion"),
            ]),
        SectionModel(model: "D", items: [
            KSectionModel(name: "だいちろ", gitHubID: "mokumoku"),
            KSectionModel(name: "David Alejandro", gitHubID: "davidlondono"),
            KSectionModel(name: "David Paschich", gitHubID: "dpassage"),
            ]),
        SectionModel(model: "E", items: [
            KSectionModel(name: "Esteban Torres", gitHubID: "esttorhe"),
            KSectionModel(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            ]),
        SectionModel(model: "F", items: [
            KSectionModel(name: "Florent Pillet", gitHubID: "fpillet"),
            KSectionModel(name: "Francis Chong", gitHubID: "siuying"),
            ]),
        SectionModel(model: "G", items: [
            KSectionModel(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
            KSectionModel(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
            KSectionModel(name: "Gwendal Roué", gitHubID: "groue"),
            ]),
        SectionModel(model: "H", items: [
            KSectionModel(name: "Hiroshi Kimura", gitHubID: "muukii"),
            ]),
        SectionModel(model: "I", items: [
            KSectionModel(name: "Ivan Bruel", gitHubID: "ivanbruel"),
            ]),
        SectionModel(model: "J", items: [
            KSectionModel(name: "Jeon Suyeol", gitHubID: "devxoul"),
            KSectionModel(name: "Jérôme Alves", gitHubID: "jegnux"),
            KSectionModel(name: "Jesse Farless", gitHubID: "solidcell"),
            KSectionModel(name: "Junior B.", gitHubID: "bontoJR"),
            KSectionModel(name: "Justin Swart", gitHubID: "justinswart"),
            ]),
        SectionModel(model: "K", items: [
            KSectionModel(name: "Karlo", gitHubID: "floskel"),
            KSectionModel(name: "Krunoslav Zaher", gitHubID: "kzaher"),
            ]),
        SectionModel(model: "L", items: [
            KSectionModel(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            KSectionModel(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
            KSectionModel(name: "Leo Picado", gitHubID: "leopic"),
            KSectionModel(name: "Libor Huspenina", gitHubID: "libec"),
            KSectionModel(name: "Lukas Lipka", gitHubID: "lipka"),
            KSectionModel(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
            ]),
        SectionModel(model: "M", items: [
            KSectionModel(name: "Marin Todorov", gitHubID: "icanzilb"),
            KSectionModel(name: "Maurício Hanika", gitHubID: "mAu888"),
            KSectionModel(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            ]),
        SectionModel(model: "N", items: [
            KSectionModel(name: "Nathan Kot", gitHubID: "nathankot"),
            ]),
        SectionModel(model: "O", items: [
            KSectionModel(name: "Orakaro", gitHubID: "DTVD"),
            KSectionModel(name: "Orta", gitHubID: "orta"),
            ]),
        SectionModel(model: "P", items: [
            KSectionModel(name: "Paweł Urbanek", gitHubID: "pawurb"),
            KSectionModel(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            KSectionModel(name: "PG Herveou", gitHubID: "pgherveou"),
            ]),
        SectionModel(model: "R", items: [
            KSectionModel(name: "Rui Costa", gitHubID: "ruipfcosta"),
            KSectionModel(name: "Ryo Fukuda", gitHubID: "yuzushioh")
            ]),
        SectionModel(model: "S", items: [
            KSectionModel(name: "Scott Gardner", gitHubID: "scotteg"),
            KSectionModel(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
            KSectionModel(name: "Sendy Halim", gitHubID: "sendyhalim"),
            KSectionModel(name: "Serg Dort", gitHubID: "sergdort"),
            KSectionModel(name: "Shai Mishali", gitHubID: "freak4pc"),
            KSectionModel(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
            KSectionModel(name: "Shenghan Chen", gitHubID: "zzdjk6"),
            KSectionModel(name: "Shunki Tan", gitHubID: "milkit"),
            KSectionModel(name: "Spiros Gerokostas", gitHubID: "sger"),
            KSectionModel(name: "Stefano Mondino", gitHubID: "stefanomondino")
            ]),
        SectionModel(model: "T", items: [
            KSectionModel(name: "Thane Gill", gitHubID: "thanegill"),
            KSectionModel(name: "Thomas Duplomb", gitHubID: "tomahh"),
            KSectionModel(name: "Tomasz Pikć", gitHubID: "pikciu"),
            KSectionModel(name: "Tony Arnold", gitHubID: "tonyarnold"),
            KSectionModel(name: "Torsten Curdt", gitHubID: "tcurdt")
            ]),
        SectionModel(model: "V", items: [
            KSectionModel(name: "Vladimir Burdukov", gitHubID: "chipp")
            ]),
        SectionModel(model: "W", items: [
            KSectionModel(name: "Wolfgang Lutz", gitHubID: "Lutzifer")
            ]),
        SectionModel(model: "X", items: [
            KSectionModel(name: "xixi197 Nova", gitHubID: "xixi197"),
            KSectionModel(name: "xixi198", gitHubID: "xixi198"),
            KSectionModel(name: "xixi199", gitHubID: "xixi199")
            
            ]),
        SectionModel(model: "Y", items: [
            KSectionModel(name: "Yongha Yoo", gitHubID: "inkyfox"),
            KSectionModel(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
            KSectionModel(name: "Yury Korolev", gitHubID: "yury"),
            KSectionModel(name: "Yury Ko", gitHubID: "yuryer")
            ]),
        
    ]
}
