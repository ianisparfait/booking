<?php

namespace App\Controller;

use App\Entity\Room;
use App\Service\JsonService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class RoomController extends AbstractController
{
    private EntityManagerInterface $em;
    private JsonService $js;

    public function __construct(EntityManagerInterface $em, JsonService $js) {
        $this->em = $em;
        $this->js = $js;
    }

    #[Route("/rooms", name: "create_room", methods: ["POST"])]
    public function create(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!isset($data["name"]) || !isset($data["capacity"])) {
            return new JsonResponse(["error" => "Nom et capacité sont requis"], Response::HTTP_BAD_REQUEST);
        }

        $room = new Room();
        $room->setName($data["name"]);
        $room->setCapacity($data["capacity"]);

        $this->em->persist($room);
        $this->em->flush();

        $room = $this->js->objectToJson($room, "Room");

        return new JsonResponse($room, Response::HTTP_CREATED);
    }

    #[Route("/rooms/{id}", name: "delete_room", methods: ["DELETE"])]
    public function delete(int $id): JsonResponse
    {
        $room = $this->em->getRepository(Room::class)->find($id);

        if (!$room) {
            return new JsonResponse(["error" => "Salle non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $this->em->remove($room);
        $this->em->flush();

        return new JsonResponse(["message" => "Salle supprimée avec succès"]);
    }


    #[Route("/rooms", name: "list_rooms", methods: ["GET"])]
    public function list(): JsonResponse
    {
        $rooms = $this->em->getRepository(Room::class)->findAll();

        $rooms = $this->js->arrayToJson($rooms, "Room");

        return new JsonResponse($rooms, 200);
    }

    #[Route("/rooms/{id}", name: "update_room", methods: ["PUT"])]
    public function update(Request $request, EntityManagerInterface $em, int $id): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!isset($data["name"]) || !isset($data["capacity"])) {
            return new JsonResponse(["error" => "Nom et capacité sont requis"], Response::HTTP_BAD_REQUEST);
        }

        $room = $em->getRepository(Room::class)->find($id);

        if (!$room) {
            return new JsonResponse(["error" => "Salle non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $room->setName($data["name"]);
        $room->setCapacity($data["capacity"]);

        $em->flush();

        $room = $this->js->objectToJson($room, "Room");

        return new JsonResponse($room, 200);
    }
}
