//
//  OkashiData.swift
//  MyOkashi
//
//  Created by Swift-Beginners
//

import SwiftUI

// Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: URL
} // OkashiItem ここまで

// お菓子データ検索用クラス
@Observable class OkashiData {
    // JSONのデータ構造
    struct ResultJson: Codable {
        // JSONのitem内のデータ構造
        struct Item: Codable {
            // お菓子の名称
            let name: String?
            // 掲載URL
            let url: URL?
            // 画像URL
            let image: URL?
        }
        // 複数要素
        let item: [Item]?
    } // ResultJson ここまで

    // お菓子のリスト（Identifiableプロトコル）
    var okashiList: [OkashiItem] = []


{
    "item": {
        "id": "7242",
        "name": "じゃがりこチーズカレー味",
        "kana": "じゃがりこちーずかれーあじ",
        "maker": "カルビー",
        "price": "148",
        "type": "snack",
        "regist": "2011年5月26日",
        "url": "https://sysbird.jp/toriko/2011/05/26/%e3%81%98%e3%82%83%e3%81%8c%e3%82%8a%e3%81%93%e3%83%81%e3%83%bc%e3%82%ba%e3%82%ab%e3%83%ac%e3%83%bc%e5%91%b3/",
        "tags": {
            "tag": [
                "じゃがりこ",
                "カレー",
                "チーズ",
                "期間限定"
            ]
        },
        "image": "https://sysbird.jp/toriko/wp-content/blogs.dir/2/files/2011/05/7242.jpg",
        "comment": "<p>じゃがりこファンサイトの人気投票で選ばれた味を商品化したというチーズカレー味である。カレー味は東京限定としてすでにあったが、コンビニで買えるカップ型で出たのはやはり嬉しい。いうまでもなく、じゃがりこにもっとも合った味だ。チーズは入ってなくてもいいので、もっとスパイシーさがほしい。次回に期待するのだ。恒例のダジャレは「チーズの魔法で華麗に変身」</p>\n"
    },
    "status": "OK",
    "count": "1"
}


    {
        "item": [
            {
                "id": "1060",
                "name": "ベビースターぐるぐるもんじゃ（カレー味)",
                "kana": "べびーすたーぐるぐるもんじゃかれーあじ",
                "maker": "おやつカンパニー",
                "price": "80",
                "type": "snack",
                "regist": "2003年12月19日",
                "url": "https://sysbird.jp/toriko/2003/12/19/%E3%83%99%E3%83%93%E3%83%BC%E3%82%B9%E3%82%BF%E3%83%BC%E3%81%90%E3%82%8B%E3%81%90%E3%82%8B%E3%82%82%E3%82%93%E3%81%98%E3%82%83%EF%BC%88%E3%82%AB%E3%83%AC%E3%83%BC%E5%91%B3/",
                "tags": {
                    "tag": [
                        "カレー",
                        "ベビースター"
                    ]
                },
                "image": "https://sysbird.jp/toriko/wp-content/blogs.dir/2/files/1060.gif",
                "comment": "<p>このグルグルシリーズはおいしいのだが、作るのが面倒臭い。入っていたのはベビースターにカレー粉、それと青海苔の袋だったか。説明通りに作らないとうまい具合に「もんじゃ」っぽく仕上がらないのだ。かくして出来上がったそれは見た目の気持ち悪いもの。まあ、もともと「もんじゃ」はそういうものであるから。ふやけたベビースターにトロリとしたカレースープが絡まっていい感じ。ベビースターぐるぐるDo。</p>\n"
            },
            {
                "id": "130",
                "name": "カール(南国カレー)",
                "kana": "かーるなんごくかれー",
                "maker": "明治製菓",
                "price": "110",
                "type": "snack",
                "regist": "1997年6月6日",
                "url": "https://sysbird.jp/toriko/1997/06/06/%E3%82%AB%E3%83%BC%E3%83%AB%E5%8D%97%E5%9B%BD%E3%82%AB%E3%83%AC%E3%83%BC/",
                "tags": {
                    "tag": [
                        "カレー",
                        "カール"
                    ]
                },
                "image": "https://sysbird.jp/toriko/wp-content/blogs.dir/2/files/130.gif",
                "comment": "<p>カールも20年ぐらい同じ味しかなかったというのに、最近の新製品開発には目をみはるものがある。新製品で必ずといっていいくらい出てくるのがカレー味のバリエーションだ。まさか出るとは思えなかった南国の、つまりココナッツカレーの味。ココナッツ風味は極力押さえられているようだが、くせがあるので仕方なかっただろう。やはりカレー味はいいものだ。</p>\n"
            }
        ],
        "status": "OK",
        "count": "2"
    }


    // Web API検索用メソッド　第一引数：keyword 検索したいワード
    func searchOkashi(keyword: String) {
        // デバッグエリアに出力
        print("searchOkashiメソッドで受け取った値：\(keyword)")

        // Taskは非同期で処理を実行できる
        Task {
            // ここから先は非同期で処理される
            // 非同期でお菓子を検索する
            await search(keyword: keyword)
        } // Task ここまで
    } // searchOkashi ここまで

    // 非同期でお菓子データを取得
    // @MainActorを使いメインスレッドで更新する
    @MainActor
    private func search(keyword: String) async {
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        } // guard let ここまで

        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=1&order=r") else {
            return
        } // guard let ここまで
        // デバッグエリアに出力
        print(req_url)
        
        do {
            // リクエストURLからダウンロード
            let (data, _) = try await URLSession.shared.data(from: req_url)
            // JSONDecoderのインスタンス取得
            let decoder = JSONDecoder()
            // 受け取ったJSONデータをパース（解析）して格納
            let json = try decoder.decode(ResultJson.self, from: data)

            // print(json)

            // お菓子の情報が取得できているか確認
            guard let items = json.item else { return }
            // お菓子のリストを初期化
            okashiList.removeAll()
            
            // 取得しているお菓子の数だけ処理
            for item in items {
                // お菓子の名称、掲載URL、画像URLをアンラップ
                if let name = item.name,
                   let link = item.url,
                   let image = item.image {
                    // 1つのお菓子を構造体でまとめて管理
                    let okashi = OkashiItem(name: name, link: link, image: image)
                    // お菓子の配列へ追加
                    okashiList.append(okashi)
                } // if ここまで
            } // for ここまで
            print(okashiList)
        } catch {
            // エラー処理
            print("エラーが出ました")
        } // do ここまで
    } // search ここまで
} // OkashiData ここまで
