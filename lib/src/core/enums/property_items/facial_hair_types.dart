import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

enum FacialHairTypes implements PropertyItem {
  Nothing(""),
  FullBeard("""
        <g id="Facial-Hair/Beard-Medium" transform="translate(-28.000000, -8.000000)">
									<defs>
										<path d="M105.017591,94.1296214 C101.150441,99.7213834 98.257542,95.9467308 94.1374777,92.8762163 C91.6567227,91.0272796 87.9608129,88.7275108 84.5044337,88.8410391 C81.0477114,88.7275108 77.3518016,91.0272796 74.8710466,92.8762163 C70.7509822,95.9467308 67.8580835,99.7213834 63.9909333,94.1296214 C61.0884259,89.9323547 62.3028943,82.8739117 65.014944,78.9027173 C68.8738581,73.2512381 74.1088724,75.9847769 79.9622738,75.3400279 C81.5538829,75.1648137 83.1526985,74.7228407 84.5044337,74 C85.856169,74.7228407 87.4546414,75.1648137 89.0462504,75.3400279 C94.899995,75.9847769 100.134666,73.2512381 103.993923,78.9027173 C106.70563,82.8739117 107.920098,89.9323547 105.017591,94.1296214 M140.39109,26 C136.966521,40.0748212 135.393023,54.4337754 132.909944,68.6711471 C132.392536,71.6390145 131.826063,74.5963095 131.224594,77.5496398 C131.098329,78.1697764 130.973781,80.4725746 130.362704,80.7643064 C128.511632,81.6484223 124.739149,76.9466834 123.730409,75.8851496 C121.196893,73.219256 118.684993,70.5292442 115.599415,68.437233 C109.364783,64.2102603 102.065485,61.7108818 94.4700836,61.117837 C91.2922091,60.8693859 86.9951134,61.3025234 84.000116,63.1104016 C81.0051185,61.3025234 76.7080229,60.8693859 73.5298053,61.117837 C65.9344039,61.7108818 58.6351055,64.2102603 52.4004739,68.437233 C49.3148957,70.5292442 46.8033387,73.219256 44.2694796,75.8851496 C43.2607395,76.9466834 39.4882573,81.6484223 37.6371849,80.7643064 C37.0261079,80.4725746 36.9015594,78.1697764 36.7752954,77.5496398 C36.1738255,74.5963095 35.6073527,71.6390145 35.0899445,68.6711471 C32.6072086,54.4337754 31.0337113,40.0748212 27.6091415,26 C26.6127533,26 25.7385119,44.7478165 25.6273446,46.4945731 C25.174784,53.5889755 24.6463963,60.5254529 25.3216346,67.6261326 C26.485803,79.8749043 27.6993791,95.2339402 37.032627,104.58753 C45.4659003,113.039493 57.7103052,114.806417 68.2713185,120.141327 C69.631059,120.828202 71.4347824,121.676306 73.3798667,122.37111 C75.4289129,123.934171 79.4926946,125 84.1740722,125 C89.0846465,125 93.3155222,123.827456 95.2540874,122.137856 C96.9548781,121.49261 98.5180822,120.752874 99.7285704,120.141327 C110.288776,114.805245 122.533989,113.039493 130.967262,104.58753 C140.30051,95.2339402 141.514086,79.8749043 142.678597,67.6261326 C143.353493,60.5254529 142.825105,53.5889755 142.372887,46.4945731 C142.261377,44.7478165 141.387136,26 140.39109,26 Z" id="react-path-20508"></path>
									</defs>
									<mask id="react-mask-20507" fill="white">
										<use xlink:href="#react-path-20508"></use>
									</mask>
									<use id="Beardness" fill="#252E32" fill-rule="evenodd" xlink:href="#react-path-20508"></use>
									<g id="Color/Hair/Brown" mask="url(#react-mask-20507)" fill="$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR">
										<g transform="translate(-32.000000, 0.000000)" id="Color">
											<rect x="0" y="0" width="264" height="244"></rect>
										</g>
									</g>
								</g>
        """),
  BeardLight("""
        <g id="Facial-Hair/Beard-Light" transform="translate(-28.000000, -8.000000)">
									<defs>
										<path d="M101.428403,98.1685688 C98.9148372,100.462621 96.23722,101.494309 92.8529444,100.772863 C92.2705777,100.648833 89.8963391,96.2345713 83.9998344,96.2345713 C78.1033297,96.2345713 75.7294253,100.648833 75.1467245,100.772863 C71.7624488,101.494309 69.0848316,100.462621 66.5712661,98.1685688 C61.8461772,93.855604 57.9166219,87.9081858 60.2778299,81.4191814 C61.5083844,78.0369425 63.5097479,74.3237342 67.1506257,73.2459109 C71.0384163,72.0955419 76.4968931,73.2439051 80.4147542,72.4582708 C81.6840664,72.2035248 83.0706538,71.7508657 83.9998344,71 C84.929015,71.7508657 86.3159365,72.2035248 87.5845805,72.4582708 C91.5027758,73.2439051 96.9612525,72.0955419 100.849043,73.2459109 C104.489921,74.3237342 106.491284,78.0369425 107.722173,81.4191814 C110.083381,87.9081858 106.153826,93.855604 101.428403,98.1685688 M140.081033,26 C136.670693,34.4002532 137.987774,44.8580348 137.356666,53.6758724 C136.844038,60.8431942 135.33712,71.5857526 128.972858,76.214531 C125.718361,78.5816138 119.79436,82.5598986 115.54187,81.4501943 C112.614539,80.6863848 112.302182,72.290096 108.455284,69.1469801 C104.09172,65.5823153 98.6429854,64.0160432 93.1491481,64.2578722 C90.7785381,64.3622683 85.9841367,64.3374908 83.9999331,66.1604584 C82.0157295,64.3374908 77.2216647,64.3622683 74.8510547,64.2578722 C69.3568808,64.0160432 63.9081467,65.5823153 59.5445817,69.1469801 C55.6976839,72.290096 55.3856641,80.6863848 52.4583326,81.4501943 C48.2058427,82.5598986 42.2818421,78.5816138 39.0270077,76.214531 C32.6624096,71.5857526 31.1561652,60.8431942 30.642864,53.6758724 C30.0120926,44.8580348 31.3291729,34.4002532 27.9188335,26 C26.2597768,26 27.3540339,42.1288693 27.3540339,42.1288693 L27.3540339,62.4851205 C27.3856735,77.7732046 36.935095,100.655445 58.1080116,109.393004 C63.2861266,111.52982 75.0153111,115 83.9999331,115 C92.9845551,115 104.71374,111.860188 109.891855,109.723371 C131.064771,100.985813 140.614193,77.7732046 140.646169,62.4851205 L140.646169,42.1288693 C140.646169,42.1288693 141.740089,26 140.081033,26" id="react-path-22754"></path>
									</defs>
									<mask id="react-mask-22753" fill="white">
										<use xlink:href="#react-path-22754"></use>
									</mask>
									<use id="Lite-Beard" fill="#331B0C" fill-rule="evenodd" xlink:href="#react-path-22754"></use>
									<g id="Color/Hair/Brown" mask="url(#react-mask-22753)" fill="$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR">
										<g transform="translate(-32.000000, 0.000000)" id="Color">
											<rect x="0" y="0" width="264" height="244"></rect>
										</g>
									</g>
								</g>
        """),
  MoustacheFancy("""
        <g id="Facial-Hair/Moustache-Fancy" transform="translate(-28.000000, -9.000000)">
									<defs>
										<path d="M84.0002865,69.2970648 C77.2083681,65.7112456 67.5782013,65.1489138 62.3885276,67.1316942 C56.6144416,69.3374281 51.5052994,75.5829845 42.6388201,72.8283797 C42.2699314,72.7136458 41.9094725,73.0449523 42.0204089,73.408662 C43.3937943,77.9183313 51.0278347,81.0068878 53.6221945,81.1080652 C64.961124,81.549609 74.0949802,72.8302891 84.0002865,72.1614794 C93.9055921,72.8302891 103.03945,81.549609 114.378714,81.1080652 C116.972736,81.0068878 124.607113,77.9183313 125.980498,73.408662 C126.091098,73.0449523 125.730639,72.7136458 125.36175,72.8283797 C116.495271,75.5829845 111.386129,69.3374281 105.612044,67.1316942 C100.422371,65.1489138 90.7922044,65.7112456 84.0002865,69.2970648 Z" id="react-path-23349"></path>
									</defs>
									<mask id="react-mask-23348" fill="white">
										<use xlink:href="#react-path-23349"></use>
									</mask>
									<use id="Moustache-U-a-Question" fill="#28354B" fill-rule="evenodd" xlink:href="#react-path-23349"></use>
									<g id="Color/Hair/Brown" mask="url(#react-mask-23348)" fill="$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR">
										<g transform="translate(-32.000000, 0.000000)" id="Color">
											<rect x="0" y="0" width="264" height="244"></rect>
										</g>
									</g>
								</g>
        """),
  That80sMoustache("""
        <g id="Facial-Hair/Moustache-Magnum" transform="translate(-28.000000, -9.000000)">
									<defs>
										<path d="M83.9980103,74.839711 C83.4569991,75.6087366 82.761047,76.2496937 81.949688,76.6891498 C73.0477917,81.5102869 63.8767499,77.3322546 58.8763101,77.6298353 C56.459601,77.7739966 53.3405442,79.4153191 52.2155358,77.6791014 C50.9768736,75.7669804 55.0680827,65.2207224 64.7214121,63.4643353 C71.7310704,62.1893309 81.4972391,63.6024033 83.9980103,66.9380109 C86.4987814,63.6024033 96.2649453,62.1893309 103.274279,63.4643353 C112.927938,65.2207224 117.019147,75.7669804 115.780485,77.6791014 C114.655476,79.4153191 111.53642,77.7739966 109.119711,77.6298353 C104.118941,77.3322546 94.948229,81.5102869 86.0463327,76.6891498 C85.2349736,76.2496937 84.5390216,75.6087366 83.9980103,74.839711 Z" id="react-path-23820"></path>
									</defs>
									<mask id="react-mask-23819" fill="white">
										<use xlink:href="#react-path-23820"></use>
									</mask>
									<use id="Hey..." fill="#28354B" fill-rule="evenodd" xlink:href="#react-path-23820"></use>
									<g id="Color/FacialHair" mask="url(#react-mask-23819)" fill="$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR">
										<g transform="translate(-32.000000, 0.000000)" id="Color">
											<rect x="0" y="0" width="264" height="244"></rect>
										</g>
									</g>
								</g>
        """);

  final String svg;

  const FacialHairTypes(this.svg);

  String get label => this.name;

  String get value => this.svg;
}