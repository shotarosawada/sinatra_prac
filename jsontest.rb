require "json"
json = '{
        "message": null,
        "results": [
                {
                        "address1": "熊本県",
                        "address2": "熊本市南区",
                        "address3": "八幡",
                        "kana1": "ｸﾏﾓﾄｹﾝ",
                        "kana2": "ｸﾏﾓﾄｼﾐﾅﾐｸ",
                        "kana3": "ﾔﾊﾀ",
                        "prefcode": "43",
                        "zipcode": "8614113"
                }
        ],
        "status": 200
}'

json2hash =  JSON.parse(json, symbolize_names: true)

results = json2hash[:results][0]
# puts(results)
results.each do |key, value|
    print(key,":",value,"\n")
end
