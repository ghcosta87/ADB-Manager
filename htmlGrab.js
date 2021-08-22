var myValueObjects

function grabImage(device) {
    var xhr = new XMLHttpRequest();

    let newSearchString=device.replace(" ","+")
    console.log(newSearchString)
    var bingImageSearch="https://bing-image-search1.p.rapidapi.com/images/search?q="+newSearchString+"&count=4"
    var texto_html; var textFilter

    xhr.withCredentials = true;

    xhr.open("GET", bingImageSearch,true);
    xhr.setRequestHeader("x-rapidapi-host", "bing-image-search1.p.rapidapi.com");
    xhr.setRequestHeader("x-rapidapi-key", "4e0a7247damsh80eefb6da7ce25ap1f6174jsn739f2d802cc5");

    xhr.onreadystatechange = function () {
        if(xhr.readyState===XMLHttpRequest.HEADERS_RECEIVED){
        }else if (xhr.readyState === xhr.DONE) {
            texto_html =xhr.responseText
            textFilter=texto_html.replace(/[\\]/g, '')
            runScript.debugNetGraber(textFilter)
            jsonSpliter(textFilter,0,0)
            console.log("ORIGINAL GET DONE !")
        }
    }
    xhr.send(data)
}

function jsonSpliter(myJson,request,picture){
    console.log(myValueObjects)
    console.log(picture)

    switch(request){
    case 0:
        var myObject=JSON.parse(myJson)
        const myValueJson=JSON.stringify(myObject.value)
        myValueObjects=JSON.parse(myValueJson)
        break;
    case 1:
        grabResultImage.source=myValueObjects[picture].contentUrl
    }




    //    contentUrl

    //    for(let i=0;i<myValueObjects.length;i++){
    //        console.log(myValueObjects[i])
    //    }

    //    return null
}
