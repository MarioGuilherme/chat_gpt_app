<?php

    require __DIR__ . "/App/Configs/App.php";

    use Mario\ApiGatewayChatGpt\Controllers\QuestionController;

    (new QuestionController())->makeAQuestion();