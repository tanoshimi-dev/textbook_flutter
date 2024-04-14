<?php declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

final class HelloController extends Controller
{
    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function __invoke(Request $request): JsonResponse
    {
        return new JsonResponse([
            'data' => [
                'message' => 'hello world!',
                'yoour_number' => random_int(1,100),
            ],
        ]);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function getMessages(Request $request): JsonResponse
    {
        return new JsonResponse([
            'data' => [
                [
                    'message' => 'message 1!',
                    'yoour_number' => random_int(1,100), 
                ],
                [
                    'message' => 'message 22!',
                    'yoour_number' => random_int(1,100), 
                ]
            ],
        ]);
    }    
}

