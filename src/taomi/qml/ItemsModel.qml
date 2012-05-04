import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: itemsModel
    Component.onCompleted: loadItemsData()
//  Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var rs = tx.executeSql('SELECT * FROM itemsData where tag = ?', [Global.tag]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        var item1 = rs.rows.item(index+1);
                        if (index + 1 == rs.rows.length) {
                            item1 = ''
                        }

                        itemsModel.append({"segment": Math.floor(index/6),
                                           "column": [{"iid": item0.iid, "cid": item0.cid, "name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price},
                                                         {"iid": item1.iid, "cid": item0.cid, "name": item1.name, "image": item1.image, "detail": item1.detail, "price": item1.price}]});
                        index+=2;
                    }
                } else {
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 0, "cid": 0, "tag": "特色", "name": "拌豆腐丝", "image": "qrc:/images/Tagine.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.0},
                                                     {"iid": 1, "cid": 0, "tag": "特色", "name": "白切鸡", "image": "qrc:/images/Tomato-Basil-Lasagne.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 2, "cid": 0, "tag": "特色", "name": "白菜心拌蜇头", "image": "qrc:/images/Tagine.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.0},
                                                     {"iid": 3, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 4, "cid": 0, "tag": "特色", "name": "拌双耳", "image": "qrc:/images/Carrot-Ginger-Soup.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.0},
                                                     {"iid": 5, "cid": 0, "tag": "特色", "name": "冰梅凉瓜", "image": "qrc:/images/CheeseStraws.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。", "price": 10.5}]});
                    itemsModel.append({"segment": 1,
                                          "column": [{"iid": 6, "cid": 0, "tag": "特色", "name": "冰镇芥兰", "image": "qrc:/images/Kermit-Lynch-Wine.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 7, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 1,
                                          "column": [{"iid": 8, "cid": 0, "tag": "特色", "name": "朝鲜辣白菜", "image": "qrc:/images/Blueberry_muffins.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 9, "cid": 0, "tag": "特色", "name": "陈皮兔肉", "image": "qrc:/images/baba-ganoush.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 1,
                                          "column": [{"iid": 10, "cid": 0, "tag": "特色", "name": "川北凉粉", "image": "qrc:/images/rustic_soup.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 11, "cid": 0, "tag": "特色", "name": "刺身凉瓜", "image": "qrc:/images/Tagine_Recipe.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 2,
                                          "column": [{"iid": 12, "cid": 0, "tag": "特色", "name": "豆豉多春鱼", "image": "qrc:/images/BimBimBop.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 13, "cid": 0, "tag": "特色", "name": "夫妻肺片", "image": "qrc:/images/rustic_soup.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 2,
                                          "column": [{"iid": 14, "cid": 0, "tag": "特色", "name": "干拌牛舌", "image": "qrc:/images/Salmon_with_pesto.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 15, "cid": 0, "tag": "特色", "name": "干拌顺风", "image": "qrc:/images/Summer_Salad.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 2,
                                          "column": [{"iid": 16, "cid": 0, "tag": "特色", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "此菜清末民初便享誉中原", "price": 10.0},
                                                     {"iid": 17, "cid": 0, "tag": "特色", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "此菜清末民初便享誉中原，素有“奇味”之称。", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 18, "cid": 1, "tag": "套餐", "name": "怪味牛腱", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.0},
                                                     {"iid": 19, "cid": 1, "tag": "套餐", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 20, "cid": 1, "tag": "套餐", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 21, "cid": 1, "tag": "套餐", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 22, "cid": 1, "tag": "套餐", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 23, "cid": 1, "tag": "套餐", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 24, "cid": 2, "tag": "主食", "name": "怪味牛腱", "image": "qrc:/images/Tomato-Basil-Lasagne.png", "detail": "", "price": 10.0},
                                                     {"iid": 25, "cid": 2, "tag": "主食", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 26, "cid": 2, "tag": "主食", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 27, "cid": 2, "tag": "主食", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 28, "cid": 2, "tag": "主食", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 29, "cid": 2, "tag": "主食", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 30, "cid": 3, "tag": "浓汤", "name": "怪味牛腱", "image": "qrc:/images/Carrot-Ginger-Soup.png", "detail": "", "price": 10.0},
                                                     {"iid": 31, "cid": 3,"tag": "浓汤", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 32, "cid": 3, "tag": "浓汤", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 33, "cid": 3, "tag": "浓汤", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 34, "cid": 3, "tag": "浓汤", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 35, "cid": 3, "tag": "浓汤", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 36, "cid": 4, "tag": "小食", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 37, "cid": 4, "tag": "小食", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 38, "cid": 4, "tag": "小食", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 39, "cid": 4, "tag": "小食", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 40, "cid": 4, "tag": "小食", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 41, "cid": 4, "tag": "小食", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});


                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 42, "cid": 5, "tag": "红酒", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 43, "cid": 5, "tag": "红酒", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 44, "cid": 5, "tag": "红酒", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 45, "cid": 5, "tag": "红酒", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 46, "cid": 5, "tag": "红酒", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 47, "cid": 5, "tag": "红酒", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 48, "cid": 6, "tag": "甜品", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 49, "cid": 6, "tag": "甜品", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 50, "cid": 6, "tag": "甜品", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 51, "cid": 6, "tag": "甜品", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 52, "cid": 6, "tag": "甜品", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 53, "cid": 6, "tag": "甜品", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 54, "cid": 7, "tag": "拼盘", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 55, "cid": 7, "tag": "拼盘", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 56, "cid": 7, "tag": "拼盘", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 57, "cid": 7, "tag": "拼盘", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 58, "cid": 7, "tag": "拼盘", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 59, "cid": 7, "tag": "拼盘", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 60, "cid": 8, "tag": "炒饭", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 61, "cid": 8, "tag": "炒饭", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 62, "cid": 8, "tag": "炒饭", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 63, "cid": 8, "tag": "炒饭", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 64, "cid": 8, "tag": "炒饭", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 65, "cid": 8, "tag": "炒饭", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 66, "cid": 9, "tag": "食谱", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 67, "cid": 9, "tag": "食谱", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 68, "cid": 9, "tag": "食谱", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 69, "cid": 9, "tag": "食谱", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 70, "cid": 9, "tag": "食谱", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 71, "cid": 9, "tag": "食谱", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 72, "cid": 10, "tag": "风味", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 73, "cid": 10, "tag": "风味", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 74, "cid": 10, "tag": "风味", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 75, "cid": 10, "tag": "风味", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 76, "cid": 10, "tag": "风味", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 77, "cid": 10, "tag": "风味", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 78, "cid": 11, "tag": "时蔬", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 79, "cid": 11, "tag": "时蔬", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 80, "cid": 11, "tag": "时蔬", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 81, "cid": 11, "tag": "时蔬", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 82, "cid": 11, "tag": "时蔬", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 83, "cid": 11, "tag": "时蔬", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 84, "cid": 12, "tag": "煲仔", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 85, "cid": 12, "tag": "煲仔", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 86, "cid": 12, "tag": "煲仔", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 87, "cid": 12, "tag": "煲仔", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 88, "cid": 12, "tag": "煲仔", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 89, "cid": 12, "tag": "煲仔", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 90, "cid": 13, "tag": "沙拉", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 91, "cid": 13, "tag": "沙拉", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 92, "cid": 13, "tag": "沙拉", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 93, "cid": 13, "tag": "沙拉", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 94, "cid": 13, "tag": "沙拉", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 95, "cid": 13, "tag": "沙拉", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 96, "cid": 14, "tag": "水果", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 97, "cid": 14, "tag": "水果", "name": "红心鸭卷", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 98, "cid": 14, "tag": "水果", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 99, "cid": 14, "tag": "水果", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 100, "cid": 14, "tag": "水果", "name": "怪味牛腱", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 101, "cid": 14, "tag": "水果", "name": "红心鸭卷", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.5}]});
                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE itemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var index = 0;
                while (index < itemsModel.count) {
                    var item1 = itemsModel.get(index).column.get(0);
                    var item2 = itemsModel.get(index).column.get(1);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?)', [item1.iid, item1.cid, item1.tag, item1.name, item1.image, item1.detail, item1.price]);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?)', [item2.iid, item1.cid, item2.tag, item2.name, item2.image, item2.detail, item2.price]);
                    index++;
                }
            }
        )
    }
}
