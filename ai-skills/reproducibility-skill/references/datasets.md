# Common datasets reference (guess-and-confirm)

Purpose: when the data↔README cross-check (flags.md, F8) finds an external input, try to identify it against this list using filename patterns, variable names, and country/year structure. If a match is likely, PROPOSE a full Data Availability Statement entry and citation from the entry below, and ask the author to CONFIRM (i) the identification, (ii) the access date, and (iii) the exact version/vintage downloaded. Never present a guessed identification as fact; access dates and vintages can never be guessed — always ask.

Redistribution status here reflects general license terms; the specific extract may differ (e.g., data obtained under a special agreement). When in doubt, the author confirms, and genuinely restricted data follows the pathways in checklist.md (exclusion + access instructions, NDA, virtual verification, or DDH archiving under restricted access).

Maintainers: update this file as licenses and URLs change. Last reviewed: July 2026.

---

## World Development Indicators (WDI)
- Typical clues: filenames containing `WDI`, `API_`, indicator codes like `NY.GDP.PCAP.CD`, wide country-year Excel/CSV from databank.
- Source: World Bank. URL: https://databank.worldbank.org/source/world-development-indicators
- License: CC BY 4.0 — redistributable; raw extracts should be included in the package.
- Citation: World Bank. <year>. "World Development Indicators." Washington, DC: World Bank. [dataset]. Accessed <date>.
- DAS must record: indicator codes/variable names downloaded, access date.

## Penn World Table (PWT)
- Typical clues: `pwt` in filename (e.g., `pwt1001.dta`), variables `rgdpe`, `rgdpo`, `pop`, `hc`, `csh_*`.
- Source: Groningen Growth and Development Centre. URL: https://www.rug.nl/ggdc/productivity/pwt/ (also www.ggdc.net/pwt)
- License: CC BY 4.0 — redistributable.
- Citation: Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), "The Next Generation of the Penn World Table," American Economic Review, 105(10), 3150–3182. [dataset, version <x.y>].

## Poverty and Inequality Platform (PIP, formerly PovcalNet)
- Typical clues: `pip`, `povcal`, headcount/poverty-line variables, welfare aggregates.
- Source: World Bank. URL: https://pip.worldbank.org/
- License: CC BY 4.0 — redistributable (aggregated estimates; underlying microdata is NOT).
- Citation: World Bank. <year>. "Poverty and Inequality Platform." [dataset]. Accessed <date>.

## Worldwide Governance Indicators (WGI)
- Typical clues: `wgi`, variables like `va`, `pv`, `ge`, `rq`, `rl`, `cc` with `_est`/`_rank` suffixes.
- Source: World Bank. URL: https://www.worldbank.org/en/publication/worldwide-governance-indicators
- License: CC BY 4.0 — redistributable.
- Citation: Kaufmann, Daniel and Aart Kraay. <year>. Worldwide Governance Indicators, <year> Update. [dataset]. Accessed <date>.

## Doing Business (archived, discontinued 2021)
- Typical clues: `doingbusiness`, `DB`, topics like trading-across-borders, ease-of-doing-business scores.
- Source: World Bank archive. URL: https://archive.doingbusiness.org/
- License: CC BY 4.0 — redistributable. Note in DAS that the dataset is discontinued; state whether a comparable alternative exists for the indicator used (often none).
- Citation: World Bank. (2020). Doing Business 2020: Comparing Business Regulation in 190 Economies. Washington, DC: World Bank.

## B-READY (Business Ready, successor to Doing Business)
- Source: World Bank. URL: https://www.worldbank.org/en/businessready
- License: CC BY 4.0 — redistributable.
- Citation: World Bank. <year>. Business Ready <year>. Washington, DC: World Bank. [dataset]. Accessed <date>.

## Enterprise Surveys
- Typical clues: `es_`, firm-level microdata, `idstd`, stratification variables.
- Source: World Bank. URL: https://www.enterprisesurveys.org/
- License: registration required; microdata NOT freely redistributable — exclude from package, give access instructions (portal registration) in DAS.
- Citation: World Bank. Enterprise Surveys. [dataset]. https://www.enterprisesurveys.org. Accessed <date>.

## Global Findex
- Typical clues: `findex`, account ownership / financial inclusion variables.
- Source: World Bank. URL: https://www.worldbank.org/en/publication/globalfindex
- License: microdata available via the Microdata Library under its terms; country-level indicators CC BY 4.0. Confirm which layer is used.
- Citation: Demirgüç-Kunt, Asli, et al. <year>. Global Findex Database <year>. Washington, DC: World Bank. [dataset]. Accessed <date>.

## LSMS / national household surveys via Microdata Library
- Typical clues: `lsms`, country-wave folders, household/individual roster files.
- Source: World Bank Microdata Library. URL: https://microdata.worldbank.org/
- License: varies by study — typically public-use files require registration and are NOT redistributable. Exclude; DAS gives catalog entry (survey ID), URL, and access procedure.
- Citation: use the study-specific citation from the Microdata Library catalog page.

## DHS (Demographic and Health Surveys)
- Typical clues: file stems like `KEHR72FL`, `*IR*`, `*PR*`, `*KR*` recode files.
- Source: DHS Program / USAID. URL: https://dhsprogram.com/
- License: registration + project approval; NOT redistributable. Exclude; DAS documents the request procedure.
- Citation: per-survey citation, e.g., "<Country> Demographic and Health Survey <year> [dataset]. Rockville, MD: ICF."

## ILOSTAT
- Typical clues: `ilo`, indicator codes like `EMP_TEMP_SEX_AGE_NB`.
- Source: International Labour Organization. URL: https://ilostat.ilo.org/
- License: reuse permitted with attribution for most indicators — generally redistributable; confirm per-indicator terms.
- Citation: ILO. "ILOSTAT database." [dataset]. Accessed <date>.

## OECD data (including TiVA / ICIO, ALFS)
- Typical clues: `oecd`, `icio`, `tiva`, `alfs`; ICIO ships as large country×industry matrices.
- Source: OECD. URL: https://data-explorer.oecd.org/ ; ICIO: https://www.oecd.org/en/data/datasets/inter-country-input-output-tables.html
- License: OECD Terms & Conditions — most data reusable with attribution; generally redistributable. Record the edition/vintage carefully (ICIO editions are replaced on the site; note if the vintage used is no longer downloadable).
- Citation: OECD. <year>. "<Dataset name>". OECD. [dataset]. Accessed <date>.

## UN Comtrade
- Typical clues: `comtrade`, reporter/partner/commodity (HS/SITC) trade flows.
- Source: United Nations. URL: https://comtradeplus.un.org/
- License: free tier permits reuse with attribution; bulk/premium has additional terms. Confirm tier. Usually redistributable in extract form with attribution.
- Citation: United Nations. "UN Comtrade Database." [dataset]. Accessed <date>.

## WITS (World Integrated Trade Solution), incl. GVC databases
- Typical clues: `wits`, `gvc`, tariff/trade indicator downloads.
- Source: World Bank. URL: https://wits.worldbank.org/
- License: underlying sources vary (UNSD, WTO); WITS-computed GVC indicators from the WDR 2020 portal are redistributable with citation.
- Citation (GVC): Borin, A., Mancini, M., & Taglioni, D. (2025). "Economic consequences of trade and global value chain integration." The World Bank Economic Review.

## WTO Data (tariffs)
- Typical clues: `wto`, MFN applied tariff averages.
- Source: WTO. URL: https://data.wto.org/
- License: reuse with attribution — redistributable extracts.
- Citation: World Trade Organization. "WTO Data portal." [dataset]. Accessed <date>.

## UNCTAD TRAINS / NTM database
- Typical clues: `ntm`, `trains`, coverage ratio / frequency index.
- Source: UNCTAD. URL: https://trainsonline.unctad.org/
- License: reuse with attribution.
- Citation: UNCTAD. (2024). Making sense of Non-Tariff Measures (NTMs). United Nations Publishing. [data via TRAINS, accessed <date>].

## Barro-Lee Educational Attainment
- Typical clues: `barro`, `lee`, `BL_`, attainment shares by age group.
- Source: barrolee.com. License: freely available with citation — redistributable.
- Citation: Barro, Robert and Jong-Wha Lee. "A New Data Set of Educational Attainment in the World, 1950–2010." Journal of Development Economics 104 (2013): 184–198. [dataset, version <x>].

## Geospatial boundaries (GADM / geoBoundaries / WB Official Boundaries)
- Typical clues: `.shp`/`.gpkg`/`.geojson`, `gadm41_*`, `ADM0/1/2`.
- GADM: free for academic/non-commercial use, redistribution NOT permitted — exclude, link in DAS.
- geoBoundaries: CC BY 4.0 — redistributable. World Bank Official Boundaries: CC BY 4.0 — redistributable; required for WB publications' maps.
- Citation (WB): World Bank. "World Bank Official Boundaries." [dataset]. https://datacatalog.worldbank.org/. Accessed <date>.

## Country-specific statistical office microdata (e.g., ENOE, ENAMIN, PNAD, GEIH)
- Typical clues: national survey acronyms, person/household-level files in Spanish/Portuguese.
- ENOE/ENAMIN (INEGI, Mexico): https://www.inegi.org.mx/ — public microdata; INEGI open data terms generally permit reuse with attribution; raw files can be very large, so packages often start from documented extracts (see checklist "usable data" provision).
- PNAD/PNADC (IBGE, Brazil): https://www.ibge.gov.br/ — public microdata, reuse with attribution.
- GEIH (DANE, Colombia): https://microdatos.dane.gov.co/ — public microdata under DANE terms.
- Rule: confirm terms per survey and per vintage; document exact survey wave, module, and download path in the DAS. If the package starts from a processed extract, README must give provenance of the raw source AND the code or protocol that produces the extract.

---

## Matching procedure

1. For each external input, compute clues: filename, extension, variable names (read the header or `describe`), country/year coverage.
2. Match against this list. Report confidence: LIKELY (name+variables match), POSSIBLE (name only), UNKNOWN.
3. LIKELY/POSSIBLE → present the proposed DAS entry and citation, with blanks for access date and version, and ask the author to confirm or correct.
4. UNKNOWN → ask the author directly: where does this file come from, who produced it, under what terms? An external input with unknown provenance cannot ship and cannot be verified; this is a blocking question, not a footnote. Cryptic names (`final_merged_v2.csv`, `data_new.dta`) with no write operation in the code are the classic case.
5. Never fill in an access date, version, or vintage the author has not confirmed.
