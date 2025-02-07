<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Traplan</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
        <style>
            html {
                height: 100vh;
            }

            .container {
                display: flex;
                width: 90%;
                height: 93%;
                border: 2px solid skyblue;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
            }

            #travel-info-container {
                width: 90%;
                height: 90%;
            }

            #travel-info {
                width: 30%;
                border: 1px solid skyblue;
            }

            #travel-name {
                background-color: #f693ff;
                padding: 5%;
                font-size: larger;
            }

            #travel-name input {
                height: 40px;
                width: 300px;
                font-size: 15px
            }

            #travel-info-container {
                margin: 5%;
                height: 95%;
                overflow: auto;
            }

            #travel-period h3 {
                display: block;
            }

            #calendar {
                font-size: 9px;
                width: 90%;
                margin: 5%;
                cursor: pointer;
            }

            #map-info {
                width: 70%;
                border: 3px solid skyblue;
            }

            #day-select {
                display: none;
            }

            .form-container {
                background-color: #F2F1F1;
                padding: 20px;
                display: none;
            }

            .form-group {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .form-group label {
                width: 60px;
                margin-right: 15px;
                font-size: 14px;
            }

            .form-group input[type="text"],
            .form-group input[type="number"],
            .form-group input[type="file"] {
                flex: 1;
                padding: 5px;
                font-size: 14px;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 10px;
            }

            .form-actions button {
                padding: 5px 10px;
                font-size: 14px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-left: 10px;
            }

            .submit-btn {
                background-color: #4CAF50;
                color: #fff;
            }

            .cancel-btn {
                background-color: #f44336;
                color: #fff;
            }

            #location {
                margin-right: 10px;
            }

            #journey-display {
                height: 250px;
                margin-bottom: 10px;
                overflow: scroll;
                display: none;
            }

            #save-journey {
                background-color: #F2F1F1;
                margin-top: 10px;
                padding: 5px;
                display: none;
                justify-content: center;
                cursor: pointer;
            }

            .fas {
                cursor: pointer;
            }

            #travel-info-footer {
                margin-top: 10px;
                display: none;
                justify-content: flex-end;
            }

            #save-travel {
                color: white;
                background-color: black;
                cursor: pointer;
                margin-right: 10px;
            }

            #display-budget {
                margin-right: 10px;
            }
        </style>
    </head>
    <html>

    <body>
        <div class="container">
            <div id="travel-info">
                <div id="travel-info-container">
                    <div id="travel-name">
                        <input placeholder="이번 여행의 이름을 지어주세요!">
                    </div>
                    <div id="calendar"></div>
                    <div id="travel-period">
                        <h3>여행기간 &nbsp <i class="fas fa-calendar"></i></h3>
                        <p>달력을 드래그해주세요!</p>
                    </div>
                    <select id="day-select"> </select>
                    <div id="journey-display">

                    </div>
                    <div class="form-container">
                        <form>
                            <div class="form-group">
                                <label for="start-time">시간</label>
                                <input type="time" id="start-time" name="time" required>
                                <span>&nbsp ~ &nbsp</span>
                                <input type="time" id="end-time" required>
                            </div>
                            <div class="form-group">
                                <label for="schedule">일정 제목</label>
                                <input type="text" id="schedule" name="schedule" required>
                            </div>
                            <div class="form-group">
                                <label for="location">장소</label>
                                <input type="text" id="location" name="location" required>
                                <button id="location-btn">입력</button>
                            </div>
                            <div class="form-group">
                                <label for="budget">예산</label>
                                <input type="number" id="budget" name="budget" required>
                                ₩
                            </div>
                            <div class="form-group">
                                <label for="reservation">예약</label>
                                <input type="file" id="reservation" name="reservation">
                            </div>
                        </form>
                    </div>
                    <div id="save-journey">
                        <img src="/assets/img/add_circle.png">
                    </div>
                    <div id="travel-info-footer">
                        <span id="display-budget">총 예산 : 0</span>
                        <button id="save-travel">저장</button>
                    </div>

                </div>


            </div>
            <div id="map-info">
                <div id="map" style="width: 100%; height: 100%"></div>
            </div>
        </div>
    </body>
    <%--스크립트문--%>
        <script type="module" src="/assets/js/travelplan.js"></script>

        <!-- 구글 맵 부트스트랩 로더 -->
        <script async
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBY7CGNgsIdVaut54UGlivQkiCYAyoS19I&loading=async&libraries=geometry,marker,places,localContext&callback=initMap">
            </script>
        <script>

            // 구글 맵 구현부분
            let map;
            const $location = document.querySelector("#location");
            const $locationBtn = document.querySelector("#location-btn")

            function initMap() {
                map = new google.maps.Map(document.getElementById("map"), {
                    center: { lat: 37.564214, lng: 127.001699 },
                    zoom: 10,
                    mapId: "DEMO_MAP_ID",
                });
            }
            async function findPlaces(text) {
                const { Place } = await google.maps.importLibrary("places");
                //@ts-ignore
                const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
                const request = {
                    textQuery: text,
                    fields: ["displayName", "location", "id", "formattedAddress"],
                    language: "ko",
                    maxResultCount: 1,
                };
                //@ts-ignore
                const { places } = await Place.searchByText(request);

                if (places.length) {

                    const { LatLngBounds } = await google.maps.importLibrary("core");
                    const bounds = new LatLngBounds();
                    places.forEach((place) => {
                        //data-set에 정보 넣기
                        console.log(place);
                        $location.setAttribute("data-placeId", place.id)
                        $location.setAttribute("data-address", place.formattedAddress)



                        bounds.extend(place.location);
                        console.log(place);

                        map = new google.maps.Map(document.getElementById("map"), {
                            center: bounds.getCenter(),
                            zoom: 14,
                            mapId: "DEMO_MAP_ID",
                        });
                        const markerView = new AdvancedMarkerElement({
                            map,
                            position: place.location,
                            title: place.displayName,
                        });
                    });


                } else {
                    console.log("No results");
                }
            }
            window.initMap = initMap;


            $locationBtn.addEventListener("click", (e) => {
                e.preventDefault();
                findPlaces($location.value).then(r => {
                });
            })



        </script>
        <!-- 풀캘린더 로더 -->
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
        <%--<script src="fullcalendar/lib/locales-all.js"></script>--%>
            <%--<script src='fullcalendar/dist/index.global.js'></script>--%>

    </html>