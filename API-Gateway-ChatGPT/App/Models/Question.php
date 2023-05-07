<?php

    declare(strict_types=1);

    namespace Mario\ApiGatewayChatGpt\Models;

    class Question {
        public int $id_question;
        public int $id_user_agent;
        public int $id_ip_address;
        public string $question;
        public string $answer;
    }