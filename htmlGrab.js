var myValueObjects

function grabImage(device) {
    var xhr = new XMLHttpRequest();

    let newSearchString=device.replace(" ","+")
    var bingImageSearch="https://bing-image-search1.p.rapidapi.com/images/search?q="+newSearchString+"&count="+maximumImageResults

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
            loading_iamge_gif_visibility.text="false"
        }
    }
    xhr.send(data)
}

function jsonSpliter(myJson,request,picture){
    switch(request){
    case 0:
        try{
            var myObject=JSON.parse(myJson)
            const myValueJson=JSON.stringify(myObject.value)
            myValueObjects=JSON.parse(myValueJson)
            grabResultImage.source=myValueObjects[0].contentUrl
        }catch(e){
            searchBox.text="Nada encontrado ... Tente novamente"
        }
        break;
    case 1:
        grabResultImage.source=myValueObjects[picture].contentUrl
    }
}
