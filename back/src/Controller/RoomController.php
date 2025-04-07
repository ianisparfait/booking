<?php

namespace App\Controller;

use App\Entity\Room;
use App\Form\RoomType;
use App\Service\EntityService;
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
    private EntityService $es;
    private JsonService $js;

    public function __construct(EntityManagerInterface $em, EntityService $es, JsonService $js) {
        $this->em = $em;
        $this->es = $es;
        $this->js = $js;
    }

    #[Route("/rooms", name: "create_room", methods: ["POST"])]
    public function create(Request $request): JsonResponse
    {
        $entity = new Room();
        $form = $this->createForm(RoomType::class, $entity);

        $data = json_decode($request->getContent(), true);

        if (!isset($data["name"]) || !isset($data["capacity"])) {
            return new JsonResponse(["error" => "Champs manquant"], Response::HTTP_BAD_REQUEST);
        }

        return $this->es->CreateOrUpdate($form, $entity, $data, "Room");
    }

    #[Route("/rooms/{id}", name: "delete_room", methods: ["DELETE"])]
    public function delete(int $id): JsonResponse
    {
        $entity = $this->em->getRepository(Room::class)->find($id);

        if (!$entity) {
            return new JsonResponse(["error" => "Donnée non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $this->em->remove($entity);
        $this->em->flush();

        return new JsonResponse(["message" => "Supprimée avec succès"]);
    }


    #[Route("/rooms", name: "list_rooms", methods: ["GET"])]
    public function list(): JsonResponse
    {
        $entities = $this->em->getRepository(Room::class)->findAll();

        $entities = $this->js->arrayToJson($entities, "Room");

        return new JsonResponse($entities, 200);
    }

    #[Route("/rooms/{id}", name: "update_room", methods: ["PUT"])]
    public function update(Request $request, EntityManagerInterface $em, int $id): JsonResponse
    {
        $entity = $em->getRepository(Room::class)->find($id);
        if (!$entity) {
            return new JsonResponse(["error" => "Donnée non trouvée"], Response::HTTP_NOT_FOUND);
        }

        $data = json_decode($request->getContent(), true);
        if (!$this->es->checkFields($data, "Room")) {
            return new JsonResponse(["error" => "Champs manquant"], Response::HTTP_BAD_REQUEST);
        }

        $form = $this->createForm(RoomType::class, $entity);
        return $this->es->CreateOrUpdate($form, $entity, $data, "Room");
    }
}
