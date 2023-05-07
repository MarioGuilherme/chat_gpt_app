<?php

    $json = json_decode(file_get_contents(__DIR__ . "/settings.json"));

    define("API_CHAT_GPT", $json->API_CHAT_GPT);
    define("DATABASE", $json->DATABASE);
    define("REPORTS", $json->REPORTS);
    define("IS_DEV_ENV", $json->IS_DEV_ENV);

    unset($json);